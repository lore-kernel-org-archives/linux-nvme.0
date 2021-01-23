Return-Path: <SRS0=wnYM=G2=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FREEMAIL_REPLYTO_END_DIGIT,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 954AFC433E0
	for <linux-nvme@archiver.kernel.org>; Sat, 23 Jan 2021 00:55:02 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0281F239D4
	for <linux-nvme@archiver.kernel.org>; Sat, 23 Jan 2021 00:55:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0281F239D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=comcast.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:Reply-To:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=p8PbvIB8YKi0ouVGMPxBjqT/p/3bEEVYsbgv7BlPVcA=; b=ROKZFfSGrlyGpk
	6xdxns1j7UU32hzaBe98/RIEACvzvhsRlHSp9FFhNiiH3CjWfFADr8WstX5MRgsswYAkW2e/o2NPw
	6gH5ajV8rg1RsfyWOpgH2B/tyDzQWEXC5wIilzeXxhTvUae5GNt530qSgg70Bbp8a1xXdhX/zwGGJ
	DUUs+bm2zNd6NYcnIoD8EDuRahFshtFVz+snOhOUOHKlM4zIhXweIovXNFMEhMsHZ0ows68VO8ZdX
	A+Kk1iwviepHTTG7+cpnlSycUVx62Ifs7QjphozAActYT2ORalup8WouMga741M1c2dd5tiLIlOIe
	jWfLsmh9SCsWcVk906KQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l37CU-0001jk-8b; Sat, 23 Jan 2021 00:54:50 +0000
Received: from resqmta-ch2-06v.sys.comcast.net
 ([2001:558:fe21:29:69:252:207:38])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l37CM-0001jK-Md
 for linux-nvme@lists.infradead.org; Sat, 23 Jan 2021 00:54:43 +0000
Received: from resomta-ch2-12v.sys.comcast.net ([69.252.207.108])
 by resqmta-ch2-06v.sys.comcast.net with ESMTP
 id 36mzlcZVtsjoS37CAlzaKF; Sat, 23 Jan 2021 00:54:30 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
 s=20190202a; t=1611363270;
 bh=JkxuGv/sjDm+WPZwSYtsbloOLem1xmigvCQ1i7v0vz0=;
 h=Received:Received:Reply-To:Subject:To:From:Message-ID:Date:
 MIME-Version:Content-Type;
 b=X25KC/B0HwEg31jkgqcfBImLbhaPegQPIPdWbU0tD6OS41vrxmBF/cFucdUsV6Zzv
 beO+0UxPZFgkcqR+DDrjyP8cAh1Nm1fxKKowmjiefmp8eYXU0Dl8hAQtlx4B8xR81J
 ngNBHPcniR7uFZmgxCAbw0/dqNzA1bWf5LLfm8r7hd19NjuJ9ejBQmyRxnEKVw33vd
 vNyAyW4uisrwKgMecDEGZFqPKpwd6x32EIBnBUkAGNbKgNGI0alEKlS2UywZWk6dPO
 NnVwVNp4w2ThoL2IBNQI6ZOpNwfJXqQXAO3lZtdtnq7umIfHa2CfYyf0tcsaPksqOC
 yCOlW5c08TIfg==
Received: from [IPv6:2601:147:c380:23e0:15bc:3da9:16c9:a52a]
 ([IPv6:2601:147:c380:23e0:15bc:3da9:16c9:a52a])
 by resomta-ch2-12v.sys.comcast.net with ESMTPSA
 id 37C6llaKho85j37C7lzNRQ; Sat, 23 Jan 2021 00:54:28 +0000
X-Xfinity-VMeta: sc=-100.00;st=legit
Subject: Re: Problem with SPCC 256GB NVMe 1.3 drive - refcount_t: underflow;
 use-after-free.
To: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
References: <f50bc59c-db11-bb44-55be-7b9db1119872@comcast.net>
 <BYAPR04MB49659C0F0F0E11D166B31E0586A40@BYAPR04MB4965.namprd04.prod.outlook.com>
 <a4c75497-d170-1e0f-8608-282231ff3a8e@comcast.net>
 <BYAPR04MB496542BEF594F0380F7D41CF86A20@BYAPR04MB4965.namprd04.prod.outlook.com>
 <df46d7ce-ce70-1f43-0efd-7153761bcff0@comcast.net>
 <20210121124459.GA156577@localhost.localdomain>
 <c48abecf-8e4f-b76a-c751-1a0d239c99b3@comcast.net>
 <BYAPR04MB4965404638B4C43DBA577D1686A00@BYAPR04MB4965.namprd04.prod.outlook.com>
 <BYAPR04MB4965342B52D5C3C6D8A7892D86A00@BYAPR04MB4965.namprd04.prod.outlook.com>
From: Bradley Chapman <chapman6235@comcast.net>
Message-ID: <23f49172-5d0e-618a-199d-d568f695dc30@comcast.net>
Date: Fri, 22 Jan 2021 19:54:26 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <BYAPR04MB4965342B52D5C3C6D8A7892D86A00@BYAPR04MB4965.namprd04.prod.outlook.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210122_195442_946215_23586753 
X-CRM114-Status: GOOD (  28.61  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Reply-To: chapman6235@comcast.net
Cc: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Hello sir!

I didn't check my e-mail until this evening, so I saw all four of your 
e-mails at once. I ran the commands you specified based on the following 
information from dmesg and lspci:

dmesg:
[    1.633908] nvme nvme1: pci function 0000:04:00.0

lspci:
04:00.0 Non-Volatile memory controller: Device 1d97:2263 (rev 03)

$ cat /sys/bus/pci/devices/0000\:04\:00.0/device
0x2263

$ cat /sys/bus/pci/devices/0000\:04\:00.0/vendor
0x1d97

On 1/21/21 10:16 PM, Chaitanya Kulkarni wrote:
> On 1/21/21 6:57 PM, Chaitanya Kulkarni wrote:
>> Bradley,
>>
>> On 1/21/21 6:54 PM, Bradley Chapman wrote:
>>> I compiled the kernel from the above git tree, rebooted and attempted to
>>> mount the filesystem on the NVMe drive. This is what the kernel put into
>>> the dmesg when I attempted to list the contents of the filesystem root,
>>> create an inode for a zero-byte file and then unmount the filesystem.
>>>
>>> Brad
>> Did you get a chance to see my response to your previous email ?
>>
> You can try following patch with some modification :-
> 
>>From e162a2e91e4895ceac6f80042a87c4ba6a4fbbf5 Mon Sep 17 00:00:00 2001
> From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
> Date: Thu, 21 Jan 2021 19:05:13 -0800
> Subject: [PATCH] nvme-pci: add device quirk wip
> 
> This is work in progress patch which is based on nvme-5.12
> HEAD : b116d37fc0f5 nvmet: add lba to sect conversion helpers
> 
> Replace <YOUR DEVICE'S VENDOR ID> and <YOUR DEVICE's DEVICE ID> with
> actual values sysfs entries in patch below before you apply the patch :-
> 
> cat  /sys/bus/pci/devices/<your device id>/device
> cat  /sys/bus/pci/devices/<your device id>/vendor
> 
> This patch is not tested at all.
> 
> Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
> ---
>   drivers/nvme/host/pci.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index 25456d02eddb..c5b43bcf57b0 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -3228,6 +3228,8 @@ static const struct pci_device_id nvme_id_table[] = {
>           .driver_data = NVME_QUIRK_DISABLE_WRITE_ZEROES, },
>       { PCI_DEVICE(0x15b7, 0x2001),   /*  Sandisk Skyhawk */
>           .driver_data = NVME_QUIRK_DISABLE_WRITE_ZEROES, },
> +    { PCI_DEVICE(<YOUR DEVICE's VENDOR ID>, <YOUR DEVICE's DEVICE ID>),
> +        .driver_data = NVME_QUIRK_DISABLE_WRITE_ZEROES, },
>       { PCI_DEVICE(PCI_VENDOR_ID_APPLE, 0x2001),
>           .driver_data = NVME_QUIRK_SINGLE_VECTOR },
>       { PCI_DEVICE(PCI_VENDOR_ID_APPLE, 0x2003) },
> 

With the following patch applied to the NVMe tree, my system hard-locked 
and would not respond to Alt+SysRQ once I mounted the filesystem and 
attempted a directory listing of the root of the filesystem.

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 25456d02eddb..7ba5e8e92e19 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -3228,6 +3228,8 @@ static const struct pci_device_id nvme_id_table[] = {
                 .driver_data = NVME_QUIRK_DISABLE_WRITE_ZEROES, },
         { PCI_DEVICE(0x15b7, 0x2001),   /*  Sandisk Skyhawk */
                 .driver_data = NVME_QUIRK_DISABLE_WRITE_ZEROES, },
+       { PCI_DEVICE(0x1d97, 0x2263),   /*  SPCC */
+               .driver_data = NVME_QUIRK_SINGLE_VECTOR },
         { PCI_DEVICE(PCI_VENDOR_ID_APPLE, 0x2001),
                 .driver_data = NVME_QUIRK_SINGLE_VECTOR },
         { PCI_DEVICE(PCI_VENDOR_ID_APPLE, 0x2003) },

I don't have a serial console, nor a serial port or other suitable 
cabling to make one, so I have no console logs of what caused the hard 
lockup, and the lack of response to Alt+SysRQ+S meant that I have no 
written logs to share with you all. I'm a bit leery of hard-locking the 
system multiple times to try to snipe the dmesg, since I don't want to 
trash the other filesystems on this host. What else can I try before I 
do that?

Brad

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
