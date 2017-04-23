From: sagi@grimberg.me (Sagi Grimberg)
Date: Sun, 23 Apr 2017 15:28:26 +0300
Subject: [PATCH v2 0/4] arbitrary sg lists support
In-Reply-To: <20170423121254.GD14088@mtr-leonro.local>
References: <1492098977-5231-1-git-send-email-maxg@mellanox.com>
 <1492101079.5176.9.camel@sandisk.com>
 <c52b5ce7-5346-419d-26f2-0d4d45d20471@grimberg.me>
 <20170423103439.GC14088@mtr-leonro.local>
 <d697d360-99ca-c3ed-08e2-b89cc50a15b0@grimberg.me>
 <20170423121254.GD14088@mtr-leonro.local>
Message-ID: <a3264968-2d9e-bda5-1f23-74da248cf4d5@grimberg.me>


> i asked and didn't get answer too.
> https://www.spinics.net/lists/linux-rdma/msg46407.html

OK, I suppose that the question was to Laurence, but I'll try
to answer.

We can't really say, this reproduced for 4M transfers, which iSER
does not support without a applying higher max_sectors modparam.
But even with that, its a different code path as SRP unlike iSER
can use multiple MRs for a single transaction.

So short answer, can't say...
