From: harryxiyou@gmail.com (harryxiyou)
Date: Sun, 31 Aug 2014 01:15:11 +0800
Subject: Some confusions about NVMe
Message-ID: <CAD+1EGNi-U-8T0yzAXB2tgGEL3SLtPxaw6VHiT4Lf0fZB4Smew@mail.gmail.com>

Hi all,

I have some about NVMe as follows.

1, NVMe vs SCSI?

NVMe and SCSI all have the parallel IO but I cannot understand why we use
NVMe instead of SCSI. (Because NVMe has other better features which SCSI
does not have?)

2, Why does NVMe has low latency?

I consider a, PCIe SSDs can connect to CPU directly; b, NVMe has less IO
stack layers, right?

3, Why do we need submission queue and completion queue in NVMe and
one core could have more than one SQ and only one CQ?

I consider it would enhance parallel IO and IO performance?

4, Why do we create namespace in NVMe?

I consider it is convenient for us to allocate sequence data blocks in one
namespace, which would easily manage and control, other reasons?

5,  Actually, I am not very clear about our PRPs and SGL. I think PRPs
are just Physical Region Pages but why do we give this name for NVMe?
SGL just takes some messy data addresses into sequence table to manage?


6, After I read some specifications for NVMe, I can just understand some
concepts of NVMe. However, I don't know what are the relationships between
NVMe commands and the user data? Does NVMe use DMA way to write/read/flush
user data into SSDs?


7, Why do we call NVMe scalability, reliability, durability and space saving?

8, what is a, register interfaces in NVMe; b, end-to-end data protection?


Could anyone please give me some hints? Thanks very much in advance.


Harry
