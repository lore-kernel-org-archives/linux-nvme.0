Return-Path: <SRS0=MUCY=OP=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49B74C433F5
	for <linux-nvme@archiver.kernel.org>; Sat, 25 Sep 2021 23:40:44 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D452D6103B
	for <linux-nvme@archiver.kernel.org>; Sat, 25 Sep 2021 23:40:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org D452D6103B
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:Reply-To:List-Subscribe:List-Help:
	List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:
	In-Reply-To:Message-ID:Subject:Cc:From:To:Date:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=AjZ/8o/Fkt61a3hrJkHdsEKf3Fjqd3nSrq6gydXFslI=; b=o+cuL35CoiSBHm
	vk/NX+hoGmX7IZpKjmB10OdQhTVXJD6xllh5jD2ny/LztV8cAY2DVqPCJnIObSKYgyD5WEuDxMGen
	bVGUsQm/5a/aflZEHhoEX4PVevcqukVSWC7sST2Eyr+cgKKWj/v8mkwtHncrX3f/i5WkxQTvBbVXy
	+Fxt/EgNStBcBsIO9WREVIjs2uNjPKauIsdYIry8QZTP9ydqafjtLPrtMN6clc9jIKFiqwu0EezCy
	dHtfw7pwu4iwe3VtMlgEhLe/5elU12tQOosK60gpxv251tG52wdmMeoTtKCKByO5AunWQnfKOdBmB
	w3Cyb2WSj1OVTEjJNkqA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mUHHQ-00HPGZ-Ek; Sat, 25 Sep 2021 23:40:28 +0000
Received: from mail-4319.protonmail.ch ([185.70.43.19])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mUHHN-00HPG9-Kz
 for linux-nvme@lists.infradead.org; Sat, 25 Sep 2021 23:40:27 +0000
Date: Sat, 25 Sep 2021 23:40:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
 s=protonmail; t=1632613221;
 bh=JU9d1XuEqHX+89EhnD/H5YuEA8AAXubY0+4+MTIBjPc=;
 h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:From;
 b=n1l9yQ0lLHwv+QJ7qbt9A6Jn4Dd9T5VC0d5XMr4IwsJlZDOrjzHBDscoHaylwJ+pn
 TgP5f9zviZruN32KnCKyxaU3ca8VLov2ZJQNig8X2E5z1AOLPF+taf1FThiOVwV/5P
 eMhPRCCUu6tjg39SGJKmWFpUYJWtAlqJHARDkYc8=
To: Keith Busch <kbusch@kernel.org>
From: Orlando Chamberlain <redecorating@protonmail.com>
Cc: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "regressions@lists.linux.dev" <regressions@lists.linux.dev>,
 "gargaditya08@live.com" <gargaditya08@live.com>,
 "sagi@grimberg.me" <sagi@grimberg.me>, "hare@suse.de" <hare@suse.de>,
 "dwagner@suse.de" <dwagner@suse.de>, "hch@lst.de" <hch@lst.de>
Subject: Re: [REGRESSION] nvme: code command_id with a genctr for
 use-after-free validation crashes apple T2 SSD
Message-ID: <fa9de055-c3b8-20d3-41e0-12e43d0c336a@protonmail.com>
In-Reply-To: <20210925171618.GA116968@dhcp-10-100-145-180.wdc.com>
References: <cjJiSFV77WM51ciS8EuBcdeBcv9T83PUB-Kw3yi8PuC_LwrrUUnQ3w5RC1PbKvSYE72KryXp3wOJhv4Ov_WWIe2gKWOOo5uwuUjbbFA8HDM=@protonmail.com>
 <20210925171618.GA116968@dhcp-10-100-145-180.wdc.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210925_164025_876062_903A2064 
X-CRM114-Status: GOOD (  15.40  )
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
Reply-To: Orlando Chamberlain <redecorating@protonmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org



On 26/9/21 03:16, Keith Busch wrote:
> On Sat, Sep 25, 2021 at 01:10:42PM +0000, Orlando Chamberlain wrote:
>> Commit e7006de6c238 causes the SSD controller on Apple T2 computers to crash
>> and prevents linux from booting.
>>
>> This commit implemented a counter that is stored within the NVMe command_id,
>> however this counter makes the command_id higher than normal, causing a panic
>> on the T2 security chip that functions as the SSD controller, which then
>> causes the system to power off after a few seconds.
> 
> Ah, yet another spec non-complainat quirk from these controllers.

Apple does like to think different.

>> This is the entry in lspci -nn for the ssd:
>>
>> 04:00.0 Mass storage controller [0180]: Apple Inc. ANS2 NVMe Controller [106b:2005] (rev 01)
>>
>> This commit was included in 5.14.6 and backported to 5.10.67, but does not
>> occur in 5.14.5 and 5.10.66. I am on a MacBookPro16,1, the crash has been
>> reproduced on a MacBookPro16,2 as well.
> 
> Is the PCI VID:DID the same from in your lspci output for all affected
> macbooks?

Yes, they all have 106b:2005

>> I've tried to modify the genctr so that it is in the other side of the
>> command_id (which I thought might make the command_id's lower) with the patch
>> below, but it did not prevent the crash.
> 
> That might mean the h/w is using the command id as an index into
> internal structures. That is not spec compliant, so it sounds like
> we'll need to introduce another quirk for the macs.
> 

I've managed to get it to boot by commenting out the counter increment, which might work
as a quirk:

--- a/drivers/nvme/host/core.c

+++ b/drivers/nvme/host/core.c

@@ -1027,7 +1027,7 @@ blk_status_t nvme_setup_cmd(struct nvme_ns *ns, struct request *req)

                return BLK_STS_IOERR;

        }

 

-       nvme_req(req)->genctr++;

+       //nvme_req(req)->genctr++;

        cmd->common.command_id = nvme_cid(req);

        trace_nvme_setup_cmd(req, cmd);

        return ret;


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
