Return-Path: <SRS0=HqJo=KD=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27AD4C433B4
	for <linux-nvme@archiver.kernel.org>; Sat,  8 May 2021 00:03:41 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7035C61451
	for <linux-nvme@archiver.kernel.org>; Sat,  8 May 2021 00:03:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7035C61451
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=Puns2ocIbseXRi7MhWpHbY1lwBhTCSp1mTJL/poOf3A=; b=Vg2qqnYwkFZGkqz7gw27VQhTH
	o9pVWjzCpJrxzRMUfXm3GQPXPs9dP38DLmfvG5pjEp9bFUe67+9QfsmUAFt3J7KsVW6pS5zx6F4pw
	6koYECwnLwPIrlCBXAcAe77qMyrO2ykmqnFal/2Ot/xvBtGRCo+tHN+NtJoXsVq0U6pezXZdIEZqI
	D2ZMF0o1DMKETBk6SUAheQ9cL6dzlYy9saXnuuH6W04elIWyZM8YLv2w5nIcNMAn0G5bkP3U8xPKt
	PqbvVXbppKQ69XTjThArmKXlhhGLWeqMYS6iqcUot+6bp1zhNkmQD6co3RE/KQ7c4Gah9KWoeH0Se
	FStybQNWQ==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lfARK-008L5S-3b; Sat, 08 May 2021 00:03:26 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lfAR9-008L5E-8r
 for linux-nvme@desiato.infradead.org; Sat, 08 May 2021 00:03:15 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=Fu4Ny60S5DAemWACB9FTUbTALkzucyrOi+xvARVV2Xw=; b=xcG9QfQu47XXcBW7ry/Yqw960n
 5A/YaNiiULBBlMKsJWyh/2Vr1hLeB4c9fJMbT9UJgdF1uPO4TRynHHnf/ZvE2Y61ypL5yorFHUVO4
 5Ik3LgH9e/JaC6/AmrZdY7RDzqft9SRLTAHe5tOse/G552cXM/kNvvbBVTb9c+pNzJqNOTdfyN/hK
 LimQ+apGBVbDfuICGS0IxvuYRp0bnhzpeVMmgvEhdkUkMMwBAOHJDwsZcRY6yCkxo67a4ojvWlRAt
 0sc3XzrRExya0c9Wum6JAJ4NKf/XgfgvB4CpC/jzSNmU0n3wDIthmGjq0wQTNz3A69zsV9zWxAQrl
 buvV+eUQ==;
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lfAR6-007GbM-JP
 for linux-nvme@lists.infradead.org; Sat, 08 May 2021 00:03:13 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3196761451;
 Sat,  8 May 2021 00:03:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1620432191;
 bh=GR7DsZ0JFdkUJZpKg/LfxTW1wV2KaLfcbfIfRHmIvCo=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Dqz0VdtrJiFua72HU/Ona745PVIDUmbGnD3tHm6umKLJ6jIHh2A1oe3zxP1Pgt2SG
 oUPMFtmRCg6V08y3zKV7wVqiHMFFXGnnt0ioZ20M7EFmhRjwsHieDygn2Tcz/MukG6
 Y7Y3PCeMg+/TRmKe3OOPfuyAvV1E0i2KObTq/5b/VE3mVbsfLFLlt01V2aCs62FqyH
 Op9d3e12Ox05s1x342yhQZmkYTShqpYOP6Kmn7VziTChlFejj81RK4B1qAk4LGaCwS
 kNTXT0cWAteZXQQy3inrpOadbfo9aBzcrQJqLs0flSI7l7d+zzaxZ+CQGeVlY48n5b
 ya4aYWZ+zO7EA==
Date: Fri, 7 May 2021 17:03:08 -0700
From: Keith Busch <kbusch@kernel.org>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Hannes Reinecke <hare@suse.de>, "Ewan D. Milne" <emilne@redhat.com>,
 Daniel Wagner <dwagner@suse.de>, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org, Jens Axboe <axboe@fb.com>,
 Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v2] nvme-tcp: Check if request has started before
 processing it
Message-ID: <20210508000308.GB1485586@dhcp-10-100-145-180.wdc.com>
References: <20210311094345.ogm2lxqfuszktuhp@beryllium.lan>
 <70af5b02-10c1-ab0b-1dfc-5906216871b4@grimberg.me>
 <2fc7a320c86f75507584453dd2fbd744de5c170d.camel@redhat.com>
 <ed3ccac0-79ed-fe10-89eb-d403820b4c6a@grimberg.me>
 <20210330232813.GA1935968@dhcp-10-100-145-180.wdc.com>
 <756aef10-e693-276f-82ac-514a2832b07f@grimberg.me>
 <492b8393-fc35-f58a-3768-94632a083c93@suse.de>
 <3156c563-94a4-4278-3835-b1f56f71869a@grimberg.me>
 <20210507204052.GA1485586@dhcp-10-100-145-180.wdc.com>
 <7a45dd7f-842b-4282-909b-082b501abcdc@grimberg.me>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <7a45dd7f-842b-4282-909b-082b501abcdc@grimberg.me>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210507_170312_731551_D74BCD25 
X-CRM114-Status: GOOD (  25.54  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Fri, May 07, 2021 at 04:22:30PM -0700, Sagi Grimberg wrote:
> 
> > > > Well, that would require a modification to the CQE specification, no?
> > > > fmds was not amused when I proposed that :-(
> > > 
> > > Why would that require a modification to the CQE? it's just using say
> > > 4 msbits of the command_id to a running sequence...
> > 
> > I think Hannes was under the impression that the counter proposal wasn't
> > part of the "command_id". The host can encode whatever it wants in that
> > value, and the controller just has to return the same value.
> 
> Yea, maybe something like this?

Yes, this looks aligned with what I was thinking. Just one minor problem
below.

> diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
> index 05f31a2c64bb..96abfb0e2ddd 100644
> --- a/drivers/nvme/host/nvme.h
> +++ b/drivers/nvme/host/nvme.h
> @@ -158,6 +158,7 @@ enum nvme_quirks {
>  struct nvme_request {
>         struct nvme_command     *cmd;
>         union nvme_result       result;
> +       u8                      genctr;
>         u8                      retries;
>         u8                      flags;
>         u16                     status;
> @@ -497,6 +498,48 @@ struct nvme_ctrl_ops {
>         int (*get_address)(struct nvme_ctrl *ctrl, char *buf, int size);
>  };
> 
> +/*
> + * nvme command_id is constructed as such:
> + * | xxxx | xxxxxxxxxxxx |
> + *   gen    request tag
> + */
> +#define nvme_cid_install_genctr(gen)           ((gen & 0xf) << 12)
> +#define nvme_genctr_from_cid(cid)              ((cid & 0xf000) >> 12)
> +#define nvme_tag_from_cid(cid)                 (cid & 0xfff)
> +
> +static inline u16 nvme_cid(struct request *rq)
> +{
> +       return nvme_cid_install_genctr(nvme_req(rq)->genctr++) | rq->tag;
> +}
> +
> +static inline struct request *nvme_find_rq(struct blk_mq_tags *tags,
> +               u16 command_id)
> +{
> +       u8 genctr = nvme_genctr_from_cid(command_id);
> +       u16 tag = nvme_tag_from_cid(command_id);
> +       struct request *rq;
> +
> +       rq = blk_mq_tag_to_rq(tags, tag);
> +       if (unlikely(!rq)) {
> +               pr_err("could not locate request for tag %#x\n",
> +                       tag);
> +               return NULL;
> +       }
> +       if (unlikely(nvme_req(rq)->genctr != genctr)) {

The nvme_request 'genctr' is 8 bits, but the nvme_genctr_from_cid() can
only return 4 bits, so need to use the same mask for both.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
