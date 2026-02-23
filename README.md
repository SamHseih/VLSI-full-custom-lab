
# VLSI SPICE Simulation Labs 實驗整理

本文件涵蓋了數位積體電路設計的一系列 SPICE 電路模擬實驗內容，包含基礎電路元件、效能縮放、不同邏輯家族、尺寸最佳化、加法器與比較器效能分析，以及動態電路設計 。

## LAB-1 基礎電路元件

本實驗旨在編寫 SPICE 檔，觀察基礎邏輯閘波形並量測 Delay time 與 Power consumption 。

* **Inverter 暫態分析**：觀察波形並量測延遲與功耗，負載為 0.05p 。尺寸調整以 Inverter 為基礎，PMOS 與 NMOS 的寬度 (W) 比例通常為 2:1，以使上升與下降時間相等 。


* **2-input & 4-input NAND**：編寫 SPICE 檔，量測 Delay time, Power consumption, 和 Power-Delay-Product 。需掃描 NMOS 尺寸並整理變化趨勢圖 。


* **2-input & 4-input NOR**：重複上述步驟，觀察 NOR 邏輯閘的特性並掃描電晶體尺寸 。


* **2-input & 4-input XOR**：編寫 XOR 電路並量測相關效能指標，調整 PMOS 與 NMOS 比例並掃描尺寸 。



## LAB-2 Scaling Property

探討電路架構縮放對效能的影響 。

* **Fan-in 與 Fan-out 分析**：探討輸入數 (fan-in) 和輸出數 (fan-out) 對 delay 以及 power 的影響 。


* 分別編寫 2、4、6、8-input NAND，觀察波形並量測效能，整理隨 fan-in 變化的趨勢圖 。


* 掃描 4-input NAND 的負載電容 (0.02p 到 0.3p)，整理隨 fan-out 變化的趨勢圖 。




* **Cascade-stage 分析**：分析不同級數 (串接) 對 delay 以及 power 的影響 。將 2-input NAND 串接四級，量測各級輸出的 Delay time 。


* **NOR 電路替換**：將 NAND 改成 NOR 電路，重複上述的 fan-in、fan-out 與 cascade-stage 效能分析 。



## LAB-3 Various CMOS Logic Families

以 XOR 為基礎，分析三種不同 Logic Families 的電路特性 。

* **觀察項目**：在固定尺寸下觀察不同負載的結果；在固定負載下觀察不同輸入頻率的結果 。


* **LAB3-1 Static CMOS 3-input XOR**：掃描負載電容 (0.05p 到 0.5p) 並調整輸入頻率 (2倍至16倍)，量測延遲與功耗 。


* **LAB3-2 Pseudo-NMOS 3-input XOR**：編寫 Pseudo-NMOS 架構，重複負載與頻率掃描實驗 。


* **LAB3-3 Pass-transistor 3-input XOR**：編寫 Pass-transistor 架構，掃描負載電容 (0.05p 到 0.3p) 與頻率，比較效能差異 。



## LAB-4 Optimizing the Size for Inverter Chain

最佳化反相器串接鏈的尺寸設計 。

* **實驗目的**：在給定負載下，探討應採用的最佳反相器級數，以及如何設置反相器尺寸 。


* **尺寸倍數原則**：若輸出與輸入負載倍數為 64，級數為 N 時，每級間的倍數為  。


* **LAB 4-1**：當級數  時，記錄其變化 。


* **LAB 4-2**：給定特定條件與頻率 (100MHz)，找出電路的最佳化級數，並記錄  時的變化 。



## LAB-5 加法器對電壓的效能分析

了解電路尺寸設計，分析電壓改變對電路的影響，並判斷最長延遲路徑 。

* **LAB 5-1 固定電壓暫態分析**：
* **1-bit**：編寫 Full Adder，負載 0.1p，調整尺寸使 Delay 小於 0.3ns 。


* **8-bits**：串接成 8-bit carry-ripple adder，調整尺寸使 Delay 小於 1.5ns 。




* **LAB 5-2 變動電壓暫態分析**：調整 VDD (1.6V 降至 0.4V)，分別量測 1-bit 與 8-bit 加法器的 Delay time 與 Power consumption，並記錄 PDP 曲線 。



## LAB-6 Performance Analysis of Arithmetic Circuit

以比較器 (Comparator) 為例，進行 Power-Delay-Product 分析 。

* **One-Bit Comparator**：編寫比較器 SPICE 檔，掛載 0.1p 負載，調整尺寸使 Delay 小於 0.5ns 。


* **8-bit Comparator**：將一位元比較器逐步擴充至 2位元、4位元、8位元之比較器，並調整尺寸使 Delay 小於 2ns 。



## LAB-7 Dynamic CMOS Logic Circuit

針對動態電路架構 (分為 Precharge 與 Evaluation 階段) 進行實作與評估 。

* **LAB 7-1 3-input Dynamic XOR**：實現動態 XOR 電路，掃描負載電容 (0.05p 到 1p) 與輸入頻率，量測效能 。


* **LAB 7-2 Cascaded Dynamic NAND**：串接 2-input NAND/AND 四級 (Domino Logic)，觀察 out1 至 out4 的 Delay time，並整理隨級數變化的趨勢圖 。


* **LAB 7-3 8-bit Dynamic Manchester Carry-Generation Chain**：實現曼徹斯特加法器 (Manchester Adder)，時脈設定 250MHz，設定多組 Pattern 驗證功能並量測 avg_power 與 critical_delay 。
