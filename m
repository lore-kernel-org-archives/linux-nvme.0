From: m@bjorling.me (=?ISO-8859-1?Q?Matias_Bj=F8rling?=)
Date: Mon, 06 Oct 2014 12:34:05 +0200
Subject: 4K writes on nvme device vs that on ext4 running on nvme block
 device
In-Reply-To: <fc4485778d044a1cafdcc94538456580@hioexcmbx06-prd.hq.netapp.com>
References: <eedf708ac5b545a2b26ee81b60dd49d3@hioexcmbx06-prd.hq.netapp.com>
 <542BB9FC.5090507@bjorling.me>
 <fc4485778d044a1cafdcc94538456580@hioexcmbx06-prd.hq.netapp.com>
Message-ID: <5432701D.5030509@bjorling.me>

On 10/05/2014 04:23 PM, Bhattacharya, Indranil wrote:
> Thanks Matias. I don't see much difference in your tests between the two. I used 16 threads in FIO. If you increase the number of threads, do you get a larger difference?
>
> -Indranil
>

With 16 threads, and 64qdepth for each, I get:

Plain: 224787 IOPS and avg. 4484us latency
Ext4:  203671 IOPS and avg. 5008us latency

A couple of percent difference, nothing much.
