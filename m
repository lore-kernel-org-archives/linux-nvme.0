From: mrybczyn@kalray.eu (Marta Rybczynska)
Date: Thu, 23 Jun 2016 15:38:29 +0200 (CEST)
Subject: [nvme-fabrics]Fabrics over ROCEv2
Message-ID: <1755342088.51635051.1466689109109.JavaMail.zimbra@kalray.eu>

Hello,
I'm doing some interoperability tests with NVMEoF in different configurations.
I have problems setting up Mellanox ConnectX-3 Pro to perform NVMEoF in RoCE v2 mode.

I have limited the set up to 2 Mellanox cards:
* if they are connected by a cable directly it works fine, I can set up a NVMEoF
and access the disk just right. It uses ROCEv1

* if they are connected by a router (in fact a 3rd machine with different 40Gbit
cards) the discover/connect operations do not work. In the packet trace I can see
that 1st card has sent an UDP packet that looks right, but the second system
answers with ICMP port unreachable.

Has anyone tried a setup in ROCEv2 mode?

Thanks in advance,


-- 

Marta Rybczynska 

Phone : +33 6 71 09 68 03 
mrybczyn at kalray.eu
