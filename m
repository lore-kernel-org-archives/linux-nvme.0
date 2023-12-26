Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06A20C46CD3
	for <linux-nvme@archiver.kernel.org>; Tue, 26 Dec 2023 13:28:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:References:Cc:To:From:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=FEhG8FtgFS6LVtXBHGtBhRiENoKCw9Iv8y2ZPo7tAqU=; b=dLvBbgpkPQpA2yIpJDprm6PKVi
	Gv2D9WmyqO/y5Y573j5U60ciFyhoFfkry2ZLKr2KPYBlyP6jP9wjp3eRyEkPnYRPvmrwoh25qOTCa
	qEF2V6BeY13VMs2DAX1EP3x8a1nI9k+s9q1zx+I33g8ljW5y57cF6tqnfxq6g2QA/XeK/8zvsRrQE
	LqcAo5pvIN4tPBdUOJ5+cWrPwx6CnkAr+DuI9Y9Eot59tNKITcGAa48QRN1PJaS3uLu9DPjHCl+9X
	GA+UabyB1b6ZwxSSF0N1IGALDOWuAdt27HqvootZURuJ+hdYezcvuQRx8wyh1A9UiJzpwMiyFODcT
	U3ffnU3w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rI7UL-00D5nI-01;
	Tue, 26 Dec 2023 13:28:53 +0000
Received: from mail-m6033.netease.com ([210.79.60.33])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rI7UH-00D5kc-1W
	for linux-nvme@lists.infradead.org;
	Tue, 26 Dec 2023 13:28:51 +0000
Received: from [192.168.182.216] (unknown [110.185.170.227])
	by smtp.qiye.163.com (Hmail) with ESMTPA id 27D4A4C0123;
	Tue, 26 Dec 2023 21:28:00 +0800 (CST)
Message-ID: <dda859d1-41f5-423c-a9e2-900a1573c3a9@easystack.cn>
Date: Tue, 26 Dec 2023 21:27:59 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Should NVME_SC_INVALID_NS be translated to BLK_STS_IOERR instead
 of BLK_STS_NOTSUPP so that multipath(both native and dm) can failover on the
 failure?
From: Jirong Feng <jirong.feng@easystack.cn>
To: Sagi Grimberg <sagi@grimberg.me>, Christoph Hellwig <hch@lst.de>,
 Keith Busch <kbusch@kernel.org>
Cc: Jens Axboe <axboe@fb.com>, linux-nvme@lists.infradead.org,
 peng.xiao@easystack.cn
References: <9b1589fb-6f47-40bb-8aa6-22ae61145de4@easystack.cn>
 <ZW6pJAm9wgqj1HEW@kbusch-mbp> <20231205044035.GA28685@lst.de>
 <08f2c221-cca7-4d34-ab78-157d4eae4f68@grimberg.me>
 <945fa17c-f1d0-4928-972b-da29ca5c95ec@easystack.cn>
 <a99971dc-9157-4a0f-8fb7-5fa495434b99@grimberg.me>
 <b8cd8de7-9167-4b8f-b255-c022376a7c9d@easystack.cn>
In-Reply-To: <b8cd8de7-9167-4b8f-b255-c022376a7c9d@easystack.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFJQjdXWS1ZQUlXWQ8JGhUIEh9ZQVkaSBpMVhgeQ0JMTkkaSxofGVUZERMWGhIXJBQOD1
	lXWRgSC1lBWUpKS1VKQ05VSkxLVUlJTFlXWRYaDxIVHRRZQVlPS0hVSk1PSUxOVUpLS1VKQktLWQ
	Y+
X-HM-Tid: 0a8ca64f8d52022ekunm27d4a4c0123
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Nwg6ORw5NDc3VixLEgw2KD8C
	HAEaChZVSlVKTEtITkJMSUNKS0NNVTMWGhIXVRESCRQVHFUdHhUcOx4aCAIIDxoYEFUYFUVZV1kS
	C1lBWUpKS1VKQ05VSkxLVUlJTFlXWQgBWUFCTktNNwY+
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231226_052849_769973_3C3EFB3B 
X-CRM114-Status: GOOD (  12.60  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

I've tested the patch basing on kernel version 6.6.0. It seems not 
working...

here's my steps & results:

1. create a VM and make & install kernel from source applying the patch.

[root@fjr-nvmet-1 ~]# uname -r
6.6.0-mytest+

2. clone that VM.

3. create a shared volume and attach to the both VMs.

4. config nvmet as below:

VM1:

o- / 
......................................................................................................................... 
[...]
   o- hosts 
................................................................................................................... 
[...]
   o- ports 
................................................................................................................... 
[...]
   | o- 1 ................................................ [trtype=tcp, 
traddr=192.168.111.99, trsvcid=4420, inline_data_size=262144]
   |   o- ana_groups 
.......................................................................................................... 
[...]
   |   | o- 1 
..................................................................................................... 
[state=optimized]
   |   o- referrals 
........................................................................................................... 
[...]
   |   o- subsystems 
.......................................................................................................... 
[...]
   |     o- 
nqn.2014-08.org.nvmexpress:NVMf:uuid:cf4bb93c-949f-4532-a5c1-b8bd267a4e06 
......................................... [...]
   o- subsystems 
.............................................................................................................. 
[...]
     o- 
nqn.2014-08.org.nvmexpress:NVMf:uuid:cf4bb93c-949f-4532-a5c1-b8bd267a4e06 
[version=1.3, allow_any=1, serial=308df2776344fdd17cba]
       o- allowed_hosts 
....................................................................................................... 
[...]
       o- namespaces 
.......................................................................................................... 
[...]
         o- 1 .......................................... [path=/dev/vdc, 
uuid=cf4bb93c-949f-4532-a5c1-b8bd267a4e06, grpid=1, enabled]

VM2:

o- / 
......................................................................................................................... 
[...]
   o- hosts 
................................................................................................................... 
[...]
   o- ports 
................................................................................................................... 
[...]
   | o- 1 ............................................... [trtype=tcp, 
traddr=192.168.111.111, trsvcid=4420, inline_data_size=262144]
   |   o- ana_groups 
.......................................................................................................... 
[...]
   |   | o- 1 
..................................................................................................... 
[state=optimized]
   |   o- referrals 
........................................................................................................... 
[...]
   |   o- subsystems 
.......................................................................................................... 
[...]
   |     o- 
nqn.2014-08.org.nvmexpress:NVMf:uuid:cf4bb93c-949f-4532-a5c1-b8bd267a4e06 
......................................... [...]
   o- subsystems 
.............................................................................................................. 
[...]
     o- 
nqn.2014-08.org.nvmexpress:NVMf:uuid:cf4bb93c-949f-4532-a5c1-b8bd267a4e06 
[version=1.3, allow_any=1, serial=0dcf77d36826000cc5a0]
       o- allowed_hosts 
....................................................................................................... 
[...]
       o- namespaces 
.......................................................................................................... 
[...]
         o- 1 .......................................... [path=/dev/vdc, 
uuid=cf4bb93c-949f-4532-a5c1-b8bd267a4e06, grpid=1, enabled]

5. create a host vm(CentOS 8.1, kernel version 
4.18.0-147.3.1.el8_1.aarch64), config dm multipath

[root@fjr-vm1 ~]# cat /etc/multipath/conf.d/nvme.conf
devices {
     device {
                 vendor                  "NVME"
                 product                 "Linux"
                 path_selector           "round-robin 0"
                 path_grouping_policy    failover
                 uid_attribute           ID_SERIAL
                 prio                    "ANA"
                 path_checker            "none"
                 #rr_min_io               100
                 #rr_min_io_rq            "1"
                 #fast_io_fail_tmo        15
                 #dev_loss_tmo            600
                 #rr_weight               uniform
                 rr_weight               priorities
                 failback                immediate
                 no_path_retry           queue
     }
}


6. connect nvme on host, finally it looks like:

[root@fjr-vm1 ~]# nvme list
Node             SN Model                                    Namespace 
Usage                      Format           FW Rev
---------------- -------------------- 
---------------------------------------- --------- 
-------------------------- ---------------- --------
/dev/nvme0n1     0dcf77d36826000cc5a0 
Linux                                    1         107.37  GB / 107.37  
GB    512   B +  0 B   6.6.0-my
/dev/nvme1n1     308df2776344fdd17cba 
Linux                                    1         107.37  GB / 107.37  
GB    512   B +  0 B   6.6.0-my

[root@fjr-vm1 ~]# nvme list-subsys
nvme-subsys0 - 
NQN=nqn.2014-08.org.nvmexpress:NVMf:uuid:cf4bb93c-949f-4532-a5c1-b8bd267a4e06
\
  +- nvme0 tcp traddr=192.168.111.111 trsvcid=4420 live
  +- nvme1 tcp traddr=192.168.111.99 trsvcid=4420 live

[root@fjr-vm1 ~]# multipath -ll
mpatha (Linux_0dcf77d36826000cc5a0) dm-0 NVME,Linux
size=100G features='1 queue_if_no_path' hwhandler='0' wp=rw
|-+- policy='round-robin 0' prio=50 status=active
| `- 1:1:1:1 nvme1n1 259:1 active ready running
`-+- policy='round-robin 0' prio=50 status=enabled
   `- 0:1:1:1 nvme0n1 259:0 active ready running

7. execute fio on host, and disable namespace on the vm corresponding to 
nvme1, the same error goes again:

fio: io_u error on file /dev/dm-0: Operation not supported: write 
offset=14734594048, buflen=4096
fio: io_u error on file /dev/dm-0: Operation not supported: write 
offset=106607394816, buflen=4096
fio: pid=16076, err=95/file:io_u.c:1747, func=io_u error, 
error=Operation not supported




