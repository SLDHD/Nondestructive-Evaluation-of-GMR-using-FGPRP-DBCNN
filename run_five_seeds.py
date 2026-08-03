import subprocess
import pandas as pd
import numpy as np
import os


data_dir = r"F:\pyproject\DBCNN\mohubupinghua_fig_4A_700hz" # Change the address according to your file path

snr = 5 #Change the level of the noise according to your requirements. In this article, we use -5 to 5 dB.

seeds = [1,2,3,4,5]


all_results = []


for seed in seeds:

    print("="*60)
    print(f"Running seed {seed}")
    print("="*60)


    command = [
        "python",
        "attention-enhanced_DBCNN.py",
        "--data_dir",
        data_dir,
        "--snr",
        str(snr),
        "--seed",
        str(seed)
    ]


    subprocess.run(
        command,
        encoding="utf-8",
        errors="ignore"
    )


    # 读取保存的结果
    file = f"metrics_seed_{seed}.csv"


    if os.path.exists(file):

        df = pd.read_csv(file)

        all_results.append(df)


        print(df)


    else:

        print(
            f"{file} not found"
        )


# 合并五次结果

results = pd.concat(all_results)


print("\nFive seed results:")
print(results)


summary = pd.DataFrame({
    "Mean":
    results.mean(numeric_only=True),

    "Std":
    results.std(numeric_only=True)
})


print("\nMean ± Std:")
print(summary)


summary.to_csv(
    "five_seed_summary.csv"
)