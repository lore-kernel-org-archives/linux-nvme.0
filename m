Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20C09C87FCB
	for <linux-nvme@archiver.kernel.org>; Wed, 30 Jul 2025 17:34:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Subject:From:To:MIME-Version:Date:Message-ID:Reply-To:Cc:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=SguGLqfEvVCTCwe6e+pssbJ/eI9Ng1wWGJMgNH1FuJ4=; b=SOsY3QLkUaotEB2jbJZCYUr7e+
	P1Vh/HNB57OKmupkZO1qkbQjv6isJ3vnJBqHc2FLU3eHWH/3L17JFe1GjVFD8Tozy1yE0J0wLg25p
	7Tl6kisZevGeX/HZMgwM/afZlZhoKsYRsINL0xP+pG2ZR48WlwiZeoT0i60OKUq+Dk1ia7gFW1kJl
	1co+4DG6c5tSVYjBU0e+bm7ILQHpPpPGXOR34/0AL61dyrK7hLQpKzBTK4I5b/DAC0C8TBTUrYWTx
	8ROLalXWNzp0h26gWjoSsyNw1YGREsrz48IOraRfWREUHowqR1sF3DNfsjgqnHHEhE/k+tCrNehru
	VtkyJfkg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uhAhQ-000000027e9-2872;
	Wed, 30 Jul 2025 17:34:44 +0000
Received: from jowisz.mejor.pl ([185.16.39.97])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uhAfc-000000027Ve-2Ou5
	for linux-nvme@lists.infradead.org;
	Wed, 30 Jul 2025 17:32:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mejor.pl;
	s=cokolwiek18; h=Content-Transfer-Encoding:Content-Type:Subject:From:To:
	MIME-Version:Date:Message-ID:Sender:Reply-To:Cc:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=SguGLqfEvVCTCwe6e+pssbJ/eI9Ng1wWGJMgNH1FuJ4=; b=Tmg9fnOL3nw7zSAw/fvhQs8X5Y
	Q6Ux/oypNpTqyG0qR4qgV2NFvvI1+W0x3Oou6N6jQzwxCSI00nDvuQgCbmMcYcl8aNuUd3h3LHj3D
	nS2Nzin9b9CpVKCB6a25ehsh5DJoDUlx3SeE2wyX9eBgAOE1o/jVtW8qWE29dRtjJk8x4w+zGUOdQ
	RHNAMxbgf0SpY7d6bLi12FiPtxdnmoILtKeooxIayszaD1P/4VpOZEqM2FbnuwbbyKk9lIZv9l96J
	0FsPu0Vcr/npBaSY6aQr/q2nMq+FgvvGRYyT3JoqoyFtk1yZAx2t97ROQCqpAk+uX0rKg/7r4NEHx
	hj7W02MQ==;
Message-ID: <099c059c-0e33-441a-a68b-a9f0ea5c201c@mejor.pl>
Date: Wed, 30 Jul 2025 19:31:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: linux-nvme@lists.infradead.org
From: =?UTF-8?Q?Marcin_Miros=C5=82aw?= <marcin@mejor.pl>
Content-Language: pl
Subject: [bug?] nvme1n1: Read(0x2) @ LBA 1603235393, 1 blocks, PRP Offset
 Invalid (sct 0x0 / sc 0x13) MORE
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250730_103252_798102_F06AB888 
X-CRM114-Status: UNSURE (   2.30  )
X-CRM114-Notice: Please train this message.
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

Hi,
I've got reprodocible error with nvme storage. I've got dedicated host 
with nvme disks with installed Proxmox and custom, vanilla kernel 6.16. 
Error shows in log when I resume quite big vm from hibernarnation (61GB):
[  997.927948] nvme1n1: Read(0x2) @ LBA 1603235393, 1 blocks, PRP Offset 
Invalid (sct 0x0 / sc 0x13) MORE
[  997.927959] I/O error, dev nvme1n1, sector 1603235393 op 0x0:(READ) 
flags 0x800 phys_seg 1 prio class 0
[  997.928476] bcachefs (2653db79-48d8-463b-9a92-bf51a134246e): 
/images/102/vm-102-disk-0.qcow2 offset 0: data read error, successful 
retry, self healing
[  997.928477]   u64s 8 type extent 4140:1:U32_MAX len 1 ver 0: 
durability: 2 crc: c_size 1 size 1 offset 0 nonce 0 csum crc32c 
0:c5acbb44  compress incompressible ptr: 1:1513433:577 gen 29 ptr: 
0:158128:0 gen 6
[  997.928478]   nvme1n1p4 io error
[  997.929168] nvme1n1: Read(0x2) @ LBA 1100084224, 1 blocks, PRP Offset 
Invalid (sct 0x0 / sc 0x13) MORE
[  997.929173] I/O error, dev nvme1n1, sector 1100084224 op 0x0:(READ) 
flags 0x800 phys_seg 1 prio class 0
[  997.929618] bcachefs (2653db79-48d8-463b-9a92-bf51a134246e): 
/images/102/vm-102-disk-0.qcow2 offset 0: data read error, successful 
retry, self healing
[  997.929620]   u64s 8 type extent 4140:1:U32_MAX len 1 ver 0: 
durability: 2 crc: c_size 1 size 1 offset 0 nonce 0 csum crc32c 
0:c5acbb44  compress incompressible ptr: 1:1022075:0 gen 19 ptr: 
0:158128:0 gen 6
[  997.929620]   nvme1n1p4 io error
[  997.983596] nvme1n1: Read(0x2) @ LBA 1603235394, 1 blocks, PRP Offset 
Invalid (sct 0x0 / sc 0x13) MORE
[  997.983603] I/O error, dev nvme1n1, sector 1603235394 op 0x0:(READ) 
flags 0x800 phys_seg 1 prio class 0
[  997.984055] bcachefs (2653db79-48d8-463b-9a92-bf51a134246e): 
/images/102/vm-102-disk-1.qcow2 offset 0: data read error, successful 
retry, self healing
[  997.984057]   u64s 8 type extent 4144:1:U32_MAX len 1 ver 0: 
durability: 2 crc: c_size 1 size 1 offset 0 nonce 0 csum crc32c 
0:9e2f0ab5  compress incompressible ptr: 1:1513433:578 gen 29 ptr: 
0:158128:1 gen 6
[  997.984058]   nvme1n1p4 io error
[  997.984522] nvme1n1: Read(0x2) @ LBA 1100084226, 1 blocks, PRP Offset 
Invalid (sct 0x0 / sc 0x13) MORE
[  997.984527] I/O error, dev nvme1n1, sector 1100084226 op 0x0:(READ) 
flags 0x800 phys_seg 1 prio class 0
[  997.984968] bcachefs (2653db79-48d8-463b-9a92-bf51a134246e): 
/images/102/vm-102-disk-1.qcow2 offset 0: data read error, successful 
retry, self healing
[  997.984969]   u64s 8 type extent 4144:1:U32_MAX len 1 ver 0: 
durability: 2 crc: c_size 1 size 1 offset 0 nonce 0 csum crc32c 
0:9e2f0ab5  compress incompressible ptr: 1:1022075:2 gen 19 ptr: 
0:158128:1 gen 6
[  997.984970]   nvme1n1p4 io error
[  998.051591] nvme1n1: Read(0x2) @ LBA 1603235395, 1 blocks, PRP Offset 
Invalid (sct 0x0 / sc 0x13) MORE
[  998.051598] I/O error, dev nvme1n1, sector 1603235395 op 0x0:(READ) 
flags 0x800 phys_seg 1 prio class 0
[  998.052049] bcachefs (2653db79-48d8-463b-9a92-bf51a134246e): 
/images/102/vm-102-disk-2.qcow2 offset 0: data read error, successful 
retry, self healing
[  998.052050]   u64s 8 type extent 4152:1:U32_MAX len 1 ver 0: 
durability: 2 crc: c_size 1 size 1 offset 0 nonce 0 csum crc32c 
0:7054c1fc  compress incompressible ptr: 1:1513433:579 gen 29 ptr: 
0:158128:2 gen 6
[  998.052051]   nvme1n1p4 io error
[  998.052517] nvme1n1: Read(0x2) @ LBA 1100084228, 1 blocks, PRP Offset 
Invalid (sct 0x0 / sc 0x13) MORE
[  998.052522] I/O error, dev nvme1n1, sector 1100084228 op 0x0:(READ) 
flags 0x800 phys_seg 1 prio class 0
[  998.052962] bcachefs (2653db79-48d8-463b-9a92-bf51a134246e): 
/images/102/vm-102-disk-2.qcow2 offset 0: data read error, successful 
retry, self healing
[  998.052963]   u64s 8 type extent 4152:1:U32_MAX len 1 ver 0: 
durability: 2 crc: c_size 1 size 1 offset 0 nonce 0 csum crc32c 
0:7054c1fc  compress incompressible ptr: 1:1022075:4 gen 19 ptr: 
0:158128:2 gen 6
[  998.052964]   nvme1n1p4 io error
[  998.140206] nvme1n1: Read(0x2) @ LBA 1603235396, 1 blocks, PRP Offset 
Invalid (sct 0x0 / sc 0x13) MORE
[  998.140213] I/O error, dev nvme1n1, sector 1603235396 op 0x0:(READ) 
flags 0x800 phys_seg 1 prio class 0
[  998.140654] bcachefs (2653db79-48d8-463b-9a92-bf51a134246e): 
/images/102/vm-102-disk-3.qcow2 offset 0: data read error, successful 
retry, self healing
[  998.140655]   u64s 8 type extent 4153:1:U32_MAX len 1 ver 0: 
durability: 2 crc: c_size 1 size 1 offset 0 nonce 0 csum crc32c 
0:642aa125  compress incompressible ptr: 0:623059:998 gen 25 ptr: 
1:1513433:580 gen 29
[  998.140656]   nvme1n1p4 io error
[  998.141140] nvme1n1: Read(0x2) @ LBA 1100084230, 1 blocks, PRP Offset 
Invalid (sct 0x0 / sc 0x13) MORE
[  998.141145] I/O error, dev nvme1n1, sector 1100084230 op 0x0:(READ) 
flags 0x800 phys_seg 1 prio class 0
[  998.141584] bcachefs (2653db79-48d8-463b-9a92-bf51a134246e): 
/images/102/vm-102-disk-3.qcow2 offset 0: data read error, successful 
retry, self healing
[  998.141585]   u64s 8 type extent 4153:1:U32_MAX len 1 ver 0: 
durability: 2 crc: c_size 1 size 1 offset 0 nonce 0 csum crc32c 
0:642aa125  compress incompressible ptr: 1:1022075:6 gen 19 ptr: 
0:623059:998 gen 25
[  998.141586]   nvme1n1p4 io error
[  998.215498] nvme1n1: Read(0x2) @ LBA 1603235397, 1 blocks, PRP Offset 
Invalid (sct 0x0 / sc 0x13) MORE
[  998.215504] I/O error, dev nvme1n1, sector 1603235397 op 0x0:(READ) 
flags 0x800 phys_seg 1 prio class 0
[  998.215702] bcachefs (2653db79-48d8-463b-9a92-bf51a134246e): 
/images/102/vm-102-disk-4.qcow2 offset 0: data read error, successful 
retry, self healing
[  998.215703]   u64s 8 type extent 4156:1:U32_MAX len 1 ver 0: 
durability: 2 crc: c_size 1 size 1 offset 0 nonce 0 csum crc32c 
0:45e3f22d  compress incompressible ptr: 1:1513433:581 gen 29 ptr: 
0:640573:514 gen 6
[  998.215705]   nvme1n1p4 io error
[  998.216926] nvme1n1: Read(0x2) @ LBA 1603235397, 1 blocks, PRP Offset 
Invalid (sct 0x0 / sc 0x13) MORE
[  998.216933] I/O error, dev nvme1n1, sector 1603235397 op 0x0:(READ) 
flags 0x800 phys_seg 1 prio class 0
[  998.218112] bcachefs (2653db79-48d8-463b-9a92-bf51a134246e): 
/images/102/vm-102-disk-4.qcow2 offset 0: data read error, successful 
retry, self healing
[  998.218114]   u64s 8 type extent 4156:1:U32_MAX len 1 ver 0: 
durability: 2 crc: c_size 1 size 1 offset 0 nonce 0 csum crc32c 
0:45e3f22d  compress incompressible ptr: 1:1022075:8 gen 19 ptr: 
0:640573:514 gen 6
[  998.218115]   nvme1n1p4 io error


nvme model: 2x  IRP-SSDPR-P44S-1K0-80

nvme error-log:
.................
  Entry[ 0]
.................
error_count     : 1338
sqid            : 5
cmdid           : 0x72f2
status_field    : 0x2013(PRP Offset Invalid: The Offset field for a PRP 
entry is invalid)
phase_tag       : 0
parm_err_loc    : 0x18
lba             : 0
nsid            : 0x1
vs              : 0
trtype          : The transport type is not indicated or the error is 
not transport related.
cs              : 0
trtype_spec_info: 0
.................


01:00.0 Non-Volatile memory controller: Phison Electronics Corporation 
E18 PCIe4 NVMe Controller (rev 01)
06:00.0 Non-Volatile memory controller: Phison Electronics Corporation 
E18 PCIe4 NVMe Controller (rev 01)


What more information I can provide to track root of this errors?
Marcin



