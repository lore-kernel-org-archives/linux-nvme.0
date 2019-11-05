Return-Path: <SRS0=AJHE=Y5=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 932A3C1747C
	for <linux-nvme@archiver.kernel.org>; Tue,  5 Nov 2019 14:06:11 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6120021882
	for <linux-nvme@archiver.kernel.org>; Tue,  5 Nov 2019 14:06:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="SbsEvXZY";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kalray.eu header.i=@kalray.eu header.b="Z6N+W+GV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6120021882
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kalray.eu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Subject:References:
	In-Reply-To:Message-ID:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=mNS6gFHzDTtdQ3h92Y7DmRwNgKLnNhKstw5hAU0EcRw=; b=SbsEvXZYOM8iGU
	nxZQutXscWo8Ca+hv4vYW3P11id/2OD61ZwOgzePWoQZUOjIcEEY/qlkkpbb4So9+RGrA2BtdPrFf
	v/1yX/k8jtvjX9Tblmpka6Kow56zm1f1zn4PhIslNXgQBnCe4/l6o4v9Qi1zLPdqs8mba7eSIH6WD
	KzQWX8WCijVtBOv8R48YvSrB+B30kaOsOKEbn6EuaAVuzj9etkT6mY+f3CFaojfRgltBh00A+xUPq
	4cZbT7ccJQKIYupabq29W4jFCD9lnEq+UIV9zUoh/pwE6GBeHbnOzXKzT3GcaJLxj2Doc/APdgNJR
	9TNN0UzfQd64uC+UCtxQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1iRzTE-0000Aq-E6; Tue, 05 Nov 2019 14:06:08 +0000
Received: from zimbra2.kalray.eu ([92.103.151.219])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iRzTC-00005u-1Y
 for linux-nvme@lists.infradead.org; Tue, 05 Nov 2019 14:06:07 +0000
Received: from localhost (localhost [127.0.0.1])
 by zimbra2.kalray.eu (Postfix) with ESMTP id 105FB27E038D;
 Tue,  5 Nov 2019 15:05:59 +0100 (CET)
Received: from zimbra2.kalray.eu ([127.0.0.1])
 by localhost (zimbra2.kalray.eu [127.0.0.1]) (amavisd-new, port 10032)
 with ESMTP id SWk3H6E5aaam; Tue,  5 Nov 2019 15:05:58 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zimbra2.kalray.eu (Postfix) with ESMTP id A275227E0F36;
 Tue,  5 Nov 2019 15:05:58 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.10.3 zimbra2.kalray.eu A275227E0F36
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kalray.eu;
 s=32AE1B44-9502-11E5-BA35-3734643DEF29; t=1572962758;
 bh=psSOKq4GiyEV36380AmvNLMCqumXhFd85hT6IKHLh7w=;
 h=Date:From:To:Message-ID:MIME-Version;
 b=Z6N+W+GV3jiuWWU6XJTU00Ul1LemICoyPalJq+WLfg7GGDBAn59rhTQQRpSY9Qzt8
 q2vNJp+EHQkPBzI4iPt7/jhthmLb8t4xd5RcwBy3dAFeJ81wpz6SF0Q6hfrCOYPUlA
 KCMCDbJCMjTTFvHVrN4mPA09AkAVZL9jFkEYXpR8=
X-Virus-Scanned: amavisd-new at zimbra2.kalray.eu
Received: from zimbra2.kalray.eu ([127.0.0.1])
 by localhost (zimbra2.kalray.eu [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id AaXVxX8jX7XR; Tue,  5 Nov 2019 15:05:58 +0100 (CET)
Received: from zimbra2.kalray.eu (localhost [127.0.0.1])
 by zimbra2.kalray.eu (Postfix) with ESMTP id 8D08427E038D;
 Tue,  5 Nov 2019 15:05:58 +0100 (CET)
Date: Tue, 5 Nov 2019 15:05:58 +0100 (CET)
From: Marta Rybczynska <mrybczyn@kalray.eu>
To: kbusch <kbusch@kernel.org>
Message-ID: <1803760845.90444797.1572962758500.JavaMail.zimbra@kalray.eu>
In-Reply-To: <20191105134530.GA2462@keith-busch>
References: <436860210.90381688.1572941457980.JavaMail.zimbra@kalray.eu>
 <20191105134530.GA2462@keith-busch>
Subject: Re: [PATCH 4/4] nvme-cli: ioctl: support 64-bit ioctls
MIME-Version: 1.0
X-Originating-IP: [192.168.40.202]
X-Mailer: Zimbra 8.8.12_GA_3794 (ZimbraWebClient - FF57 (Linux)/8.8.12_GA_3794)
Thread-Topic: nvme-cli: ioctl: support 64-bit ioctls
Thread-Index: aIEKcwjs5FD8LVO1EzDWoRQQujxmaA==
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191105_060606_292933_9DCF9505 
X-CRM114-Status: UNSURE (   7.53  )
X-CRM114-Notice: Please train this message.
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
Cc: Keith Busch <keith.busch@intel.com>,
 linux-nvme <linux-nvme@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org



----- On 5 Nov, 2019, at 14:45, kbusch kbusch@kernel.org wrote:

> On Tue, Nov 05, 2019 at 09:10:57AM +0100, Marta Rybczynska wrote:
>> @@ -600,9 +618,30 @@ static void nvme_to_passthru_cmd(struct nvme_passthru_cmd
>> *pcmd,
>>  	pcmd->cdw15 = le32_to_cpu(ncmd->common.cdw10[5]);
>>  }
> 
> You're working off of some non-public fork, and a broken one at that.
> See below.
>

It's based on https://github.com/linux-nvme/nvme-cli.git and applies to the
current master of that (66652af38042fc9624a8fbf25a325a788ccd3c82)

If there's a better one to use, please let me know.
 
>> +static void nvme_to_passthru_cmd64(struct nvme_passthru_cmd64 *pcmd,
>> +				   const struct nvme_command *ncmd)
>> +{
> 
> User space has no business using a 'struct nvme_command'. That's for
> kernel use only.
> 
>> +	assert(sizeof(*ncmd) < sizeof(*pcmd));
>> +	memset(pcmd, 0, sizeof(*pcmd));
>> +	pcmd->opcode = ncmd->common.opcode;
>> +	pcmd->flags = ncmd->common.flags;
>> +	pcmd->rsvd1 = ncmd->common.command_id;
>> +	pcmd->nsid = le32_to_cpu(ncmd->common.nsid);
>> +	pcmd->cdw2 = le32_to_cpu(ncmd->common.cdw2[0]);
>> +	pcmd->cdw3 = le32_to_cpu(ncmd->common.cdw2[1]);
>> +	/* Skip metadata and addr */
>> +	pcmd->cdw10 = le32_to_cpu(ncmd->common.cdw10[0]);
>> +	pcmd->cdw11 = le32_to_cpu(ncmd->common.cdw10[1]);
>> +	pcmd->cdw12 = le32_to_cpu(ncmd->common.cdw10[2]);
>> +	pcmd->cdw13 = le32_to_cpu(ncmd->common.cdw10[3]);
>> +	pcmd->cdw14 = le32_to_cpu(ncmd->common.cdw10[4]);
>> +	pcmd->cdw15 = le32_to_cpu(ncmd->common.cdw10[5]);
> > +}

The code was a copy of nvme_to_passthru that was introduced by 
Bart Van Assche in 301e263c.

There is only a couple of values set to nvme_command, so we can
code that directly in nvme_get_property if that's the better way.
This will require changing the older code too.

Regards,
Marta

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
