Return-Path: <SRS0=vClw=OQ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31D8BC433EF
	for <linux-nvme@archiver.kernel.org>; Sun, 26 Sep 2021 04:35:58 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CFF8E6108E
	for <linux-nvme@archiver.kernel.org>; Sun, 26 Sep 2021 04:35:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org CFF8E6108E
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:Reply-To:List-Subscribe:List-Help:
	List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:
	In-Reply-To:Message-ID:Subject:Cc:From:To:Date:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=7rIsOjjmaf0FP6oVB9Y/xvmqtoFYI6qigPN3Z87AXGQ=; b=TA1YPei2AtZ1SU
	Wakvb4SFWI7W1Y30ShUNW/dAtTLKP/6G4DCqrME+M/5FH2HlH97dyYuA4EpVYR3ozLQR8GljTIhA/
	3d+Wn5XHZFwwIJn2fAJIom5Id8NzVV/AJS0Wt+GmJWVEA1KwRWnYp6/GO08E2b4Ud1rPy2UlgpKLc
	AQ/xqT1ckKUo+pW/hNcUNxGohUq9RAPKRV95cliTFDjgrOdPeFb/7U4qpKu4XNI0Vygu5C/GSbu2H
	yXf2JPUOevbZ7hLWcIrCNj0zhXl4QXnFTzKo6h1QXm6Syey2lFicxvBTqzrBxtyA1bYn0y0oV74D/
	CTfpAVPe353HvKp0SN1A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mULtC-00HaMT-Mq; Sun, 26 Sep 2021 04:35:46 +0000
Received: from mail-4318.protonmail.ch ([185.70.43.18])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mULtA-00HaLy-Nv
 for linux-nvme@lists.infradead.org; Sun, 26 Sep 2021 04:35:46 +0000
Date: Sun, 26 Sep 2021 04:35:30 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
 s=protonmail; t=1632630937;
 bh=uyKFsLwtoH4+xjiAgqs5q5lalDBftqKXjyAvkyXZCQQ=;
 h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:From;
 b=D6D8wc0U8g/2laBhqWc22Jb32Cuv+ecXUkAP5Qm2gOGLJJ99OBPG8w0jSF8RfymZ4
 b88cNI5GOstqy1VoN+HGBMgJnyKZUa8CCMtPErfG9KS6EETcB60cK4ngdCrAAT9QkY
 6e0Kli2mR+Q++4EgREdU0VZ3KKwm8tQzs+9KrXAY=
To: Keith Busch <kbusch@kernel.org>
From: Orlando Chamberlain <redecorating@protonmail.com>
Cc: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "regressions@lists.linux.dev" <regressions@lists.linux.dev>,
 "gargaditya08@live.com" <gargaditya08@live.com>,
 "sagi@grimberg.me" <sagi@grimberg.me>, "hare@suse.de" <hare@suse.de>,
 "dwagner@suse.de" <dwagner@suse.de>, "hch@lst.de" <hch@lst.de>
Subject: Re: [REGRESSION] nvme: code command_id with a genctr for
 use-after-free validation crashes apple T2 SSD
Message-ID: <1b5d6bef-db6f-073f-8d24-4963f0df82ab@protonmail.com>
In-Reply-To: <1a6f5030-27d9-d1ae-aff4-0ed2a10dce6b@protonmail.com>
References: <cjJiSFV77WM51ciS8EuBcdeBcv9T83PUB-Kw3yi8PuC_LwrrUUnQ3w5RC1PbKvSYE72KryXp3wOJhv4Ov_WWIe2gKWOOo5uwuUjbbFA8HDM=@protonmail.com>
 <20210925171618.GA116968@dhcp-10-100-145-180.wdc.com>
 <fa9de055-c3b8-20d3-41e0-12e43d0c336a@protonmail.com>
 <20210926020839.GA96176@C02WT3WMHTD6>
 <1a6f5030-27d9-d1ae-aff4-0ed2a10dce6b@protonmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210925_213544_961696_01F396E8 
X-CRM114-Status: UNSURE (   8.80  )
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
Reply-To: Orlando Chamberlain <redecorating@protonmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 26/9/21 13:53, Orlando Chamberlain wrote:
>> Great, that's essentially what I proposed in a different thread (sorry, I see
>> now you were not copied there):
>>
>>   http://lists.infradead.org/pipermail/linux-nvme/2021-September/027665.html
>>
>> The final patch may look a bit different, but it should be okay to test with
>> the one in the link.
>>
> I've tried that patch, it doesn't crash, but /dev/nvme0, /dev/nvme0n1 etc don't show up so
> it doesn't progress past the initramfs. There weren't any errors other than preexisting
> acpi table ones.
> 

The issue was that there's a , instead of a | at the end of the second line here. It works when that is replaced with a |.

-				NVME_QUIRK_SHARED_TAGS },
+				NVME_QUIRK_SHARED_TAGS ,
+				NVME_QUIRK_SKIP_CID_GEN },


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
