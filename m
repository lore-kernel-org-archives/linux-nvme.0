From: jthumshirn@suse.de (Johannes Thumshirn)
Date: Fri, 14 Jul 2017 13:25:54 +0200
Subject: I/O Errors due to keepalive timeouts with NVMf RDMA
In-Reply-To: <a0656ff3-f2b9-4580-bf6f-8206cd73b680@grimberg.me>
References: <20170710091054.GD5105@linux-x5ow.site>
 <a940a9ea-c090-6620-a080-eb7cf6140ad3@grimberg.me>
 <20170710102049.GF5105@linux-x5ow.site>
 <77c7d11c-bd67-8663-cc10-da3af8bfcd22@grimberg.me>
 <20170710113353.GG5105@linux-x5ow.site>
 <ebc9dccc-ce68-f5f3-3e24-372b2cd7f44b@grimberg.me>
 <20170710115003.GH5105@linux-x5ow.site>
 <4df0a8a8-168f-06c4-6112-dfd2893d6e06@grimberg.me>
 <20170711085204.GA7846@linux-x5ow.site>
 <a0656ff3-f2b9-4580-bf6f-8206cd73b680@grimberg.me>
Message-ID: <20170714112554.GF8497@linux-x5ow.site>

On Tue, Jul 11, 2017@12:19:12PM +0300, Sagi Grimberg wrote:
> I didn't mean that the fabric is broken for sure, I was simply saying
> that having a 64 byte send not making it through a switch port sounds
> like a problem to me.

So JFTR I now have a 3rd setup with RoCE over mlx5 (and a Mellanox Switch) and
I can reproduce it again on this setup.

host# ibstat
CA 'mlx5_0'
	CA type: MT4115
	Number of ports: 1
	Firmware version: 12.20.1010
	Hardware version: 0
	Node GUID: 0x248a070300554504
	System image GUID: 0x248a070300554504
	Port 1:
		State: Active
		Physical state: LinkUp
		Rate: 56
		Base lid: 0
		LMC: 0
		SM lid: 0
		Capability mask: 0x04010000
		Port GUID: 0x268a07fffe554504
		Link layer: Ethernet

target# ibstat
CA 'mlx5_0'
	CA type: MT4117
	Number of ports: 1
	Firmware version: 14.20.1010
	Hardware version: 0
	Node GUID: 0x248a070300937248
	System image GUID: 0x248a070300937248
	Port 1:
		State: Down
		Physical state: Disabled
		Rate: 25
		Base lid: 0
		LMC: 0
		SM lid: 0
		Capability mask: 0x04010000
		Port GUID: 0x268a07fffe937248
		Link layer: Ethernet


host# dmesg
nvme nvme0: new ctrl: NQN "nqn.2014-08.org.nvmexpress.discovery", addr 9.9.9.6:4420
nvme nvme0: creating 24 I/O queues.
nvme nvme0: new ctrl: NQN "nvmf-test", addr 9.9.9.6:4420
test start
nvme nvme0: failed nvme_keep_alive_end_io error=-5
nvme nvme0: Reconnecting in 10 seconds...
blk_update_request: I/O error, dev nvme0n1, sector 23000728
blk_update_request: I/O error, dev nvme0n1, sector 32385208
blk_update_request: I/O error, dev nvme0n1, sector 13965416
blk_update_request: I/O error, dev nvme0n1, sector 32825384
blk_update_request: I/O error, dev nvme0n1, sector 47701688
blk_update_request: I/O error, dev nvme0n1, sector 994584
blk_update_request: I/O error, dev nvme0n1, sector 26306816
blk_update_request: I/O error, dev nvme0n1, sector 27715008
blk_update_request: I/O error, dev nvme0n1, sector 32470064
blk_update_request: I/O error, dev nvme0n1, sector 29905512
nvme0n1: detected capacity change from 68719476736 to -67550056326088704
Buffer I/O error on dev nvme0n1, logical block 0, async page read
Buffer I/O error on dev nvme0n1, logical block 0, async page read
Buffer I/O error on dev nvme0n1, logical block 0, async page read
ldm_validate_partition_table(): Disk read failed.
Buffer I/O error on dev nvme0n1, logical block 0, async page read
Buffer I/O error on dev nvme0n1, logical block 0, async page read
Buffer I/O error on dev nvme0n1, logical block 0, async page read
Buffer I/O error on dev nvme0n1, logical block 0, async page read
Buffer I/O error on dev nvme0n1, logical block 0, async page read
Buffer I/O error on dev nvme0n1, logical block 3, async page read
Buffer I/O error on dev nvme0n1, logical block 0, async page read
nvme0n1: unable to read partition table

The fio command used was:
fio --name=test --iodepth=128 --numjobs=$(nproc) --size=23g --time_based \
    --runtime=15m --filename=/dev/nvme0n1 --ioengine=libaio --direct=1 \
     --rw=randrw


-- 
Johannes Thumshirn                                          Storage
jthumshirn at suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: Felix Imend?rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N?rnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
