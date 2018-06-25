From: osandov@osandov.com (Omar Sandoval)
Date: Mon, 25 Jun 2018 12:04:29 -0700
Subject: [PATCH V2 00/14] blktests: NVMeOF new testcases for file and
 bdev ns
In-Reply-To: <BN6PR04MB120367ABC523F7DDEC83C35A867E0@BN6PR04MB1203.namprd04.prod.outlook.com>
References: <20180611091554.19639-1-chaitanya.kulkarni@wdc.com>
 <20180611221432.GB25795@vader>
 <BN6PR04MB1203184F17F7102054FF311C867F0@BN6PR04MB1203.namprd04.prod.outlook.com>
 <20180613072125.z2obhfnds7zvqx2e@linux-x5ow.site>
 <BN6PR04MB120367ABC523F7DDEC83C35A867E0@BN6PR04MB1203.namprd04.prod.outlook.com>
Message-ID: <20180625190429.GA1218@vader>

On Wed, Jun 13, 2018@08:18:03AM +0000, Chaitanya Kulkarni wrote:
> Thanks, Johannes for the review comments.
> 
> 
> Omar, let me know if you find any issues, otherwise, we can merge this series.

I was able to fix the flush tests by replacing

nvme flush /dev/"${nvmedev}n1"

With

nvme flush /dev/"${nvmedev}" -n 1

(Going off of https://github.com/linux-nvme/nvme-cli/issues/174). Does
that seem sane?

The last two tests sometimes fail like this:

nvme/016 (create/delete many NVMeOF block device-backed ns and test discovery) [failed]
runtime     ...  44.535s
    --- tests/nvme/016.out      2018-06-25 11:56:39.176313626 -0700
    +++ results/nodev/nvme/016.out.bad  2018-06-25 11:59:30.153990955 -0700
    @@ -1,6 +1,6 @@
     Running nvme/016

    -Discovery Log Number of Records 1, Generation counter 1
    +Discovery Log Number of Records 1, Generation counter 3
     =====Discovery Log Entry 0======
     trtype:  loop
     adrfam:  pci

I don't know enough about NVMe to know how important this is, but it
looks like this needs some sort of filter :)
