From: sagig@dev.mellanox.co.il (Sagi Grimberg)
Date: Thu, 7 Jan 2016 13:39:22 +0200
Subject: Maximum NVMe IO command size > 1MB?
In-Reply-To: <680a6c16f5464419b7e1974d04026951@SC-EXCH01.marvell.com>
References: <cc642ee3fec8476b9034e1ee397e8f42@SC-EXCH01.marvell.com>
 <20160106193127.GA20732@localhost.localdomain>
 <680a6c16f5464419b7e1974d04026951@SC-EXCH01.marvell.com>
Message-ID: <568E4E6A.5000907@dev.mellanox.co.il>


> The value is 2048, which seems to be 2MB.

I think 2048 is 1MB...

max_transfer_size = max_sectors_kb * sector_size =
2048K * 512 = 1MB

I don't think it's coming from any other limitation in
the block layer since I'm able to transfer 8M and more in
a single request with iser.
