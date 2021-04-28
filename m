Return-Path: <SRS0=oNUT=JZ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3F37C433B4
	for <linux-nvme@archiver.kernel.org>; Wed, 28 Apr 2021 18:02:15 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 679A8613DC
	for <linux-nvme@archiver.kernel.org>; Wed, 28 Apr 2021 18:02:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 679A8613DC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=TFdqYMmCh+1jzyavD5UMliWdAHJnJee7igTZMLIE5cM=; b=mmWZpZJsgYEO6BH8g/CWvB0Cy
	ssLHwdCwd22NFmkQdrOr5FA8Pgyph/bQAI2oxzosbF+zeb605hQcjJ82BSHVpzKHqawNjbHNmUJgw
	1qoN/BmJYRlKUWVJc9WHYW1TsPsPN9bm9NavnO4E/5opOuAiYNRIh4JhFlJs+Px8m00d+mP6oD4nn
	IFyBxnWypmH4pi5OzKZ8kjLlKGfeArhVMfj/cvUsnlp4/yWj9vAO4phkgm03dpci3cFpBthWHmvjZ
	Nc7cV+1tqwxaboyPTvnSwgIAW6YXm92sxzBZhHIA6DvYfgAQlEDS/3SvvJ981AUL4+JxKnzvAkU+u
	djHHrsM6w==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lboVa-0042QM-Bd; Wed, 28 Apr 2021 18:01:58 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lboVY-0042QC-Lb
 for linux-nvme@desiato.infradead.org; Wed, 28 Apr 2021 18:01:56 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=lH+RoXrz7pC9dQrJVYSuplivGmFIdsE4RekHA0m+Hr4=; b=eRvO5K984fkN5sfQh7hE2yH1rF
 zhvjKZLQqNLY81SMTmh/4y0GH8gmX0WVIpxJuFQLGf4HBV6TC8OdiW36ADZWOL/fXDr1YQrFhV5ab
 7JCZRSpAS96/7hcBjoY4Lbfp3blbt/iCDU1zAta+Yql/Brs7h2L/QhnIuXVK6o3krLZYiWvvC2hpq
 lfWK/U5V9Tkw+heHxBoqERUUnONQosuPtSW54/GU4TFMpRQUbtiEcAK5/DfeZKCg6R42UkkUI7l/M
 ZwVyiPz1uzxCsvz+QzRtd1P1aAQUnhpdBRtGqcEaggGbdOaTJ5wPAjMqsi2AWCWA6f7IufUCBMsbf
 gEsdJsvA==;
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lboVW-0006OC-7c
 for linux-nvme@lists.infradead.org; Wed, 28 Apr 2021 18:01:55 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id EB17561003;
 Wed, 28 Apr 2021 18:01:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1619632913;
 bh=PXx5nT8IztlAMRH3cUbuly+UC6THTL+J/QsJcVDM3uI=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=mUW7vSYEN/iP2f0uOsbPwfMBJ+z4Nmz1Rra8CPtjMv3u/nkR3qTDACmf0x7RGOHH/
 MWkCK4FD4tnK6WNNjg1WS8RRIhvyOVAtacUCDNfOU00x73+DSKSlvBhr1vugcnPFdQ
 gWeQj6bY8H8bSp1sLNHUqp/ItnRt6WKUXxIy7OT9efSpEGU6L8diPbL5JJaPE3UC/9
 gwcQCxNnMUDz2CD9wtZ8j1RINQV1LyBgIzivsUH+nEva5Gnr7RF6TsKfv9Sxa1Dnin
 0cPeax+Wh18bpiQERA4Y5jaSTdHsR8O/A1gYiMgoTsd/vn3J3Iu1sPZjdENE3I7VmZ
 eUpryz210odPQ==
Date: Thu, 29 Apr 2021 03:01:47 +0900
From: Keith Busch <kbusch@kernel.org>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org, hch@lst.de
Subject: Re: nvme tcp receive errors
Message-ID: <20210428180147.GB21854@redsun51.ssa.fujisawa.hgst.com>
References: <20210331204958.GD23886@redsun51.ssa.fujisawa.hgst.com>
 <20210402171141.GA1944994@dhcp-10-100-145-180.wdc.com>
 <53a11feb-bc49-d384-3b7b-481a0dfc70e6@grimberg.me>
 <20210405143702.GA20598@redsun51.ssa.fujisawa.hgst.com>
 <20210407195319.GA30623@redsun51.ssa.fujisawa.hgst.com>
 <8d8c5c82-f1d3-5599-ae3e-5af5ff12eb9d@grimberg.me>
 <20210427233956.GA631292@dhcp-10-100-145-180.wdc.com>
 <549e4f57-5f6e-d5ed-db63-8f82e9a7490a@grimberg.me>
 <20210428155847.GA21854@redsun51.ssa.fujisawa.hgst.com>
 <00a3b480-2885-b32b-139a-ef68ff21bad5@grimberg.me>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <00a3b480-2885-b32b-139a-ef68ff21bad5@grimberg.me>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210428_110154_330578_C509912A 
X-CRM114-Status: UNSURE (   9.93  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Wed, Apr 28, 2021 at 10:42:13AM -0700, Sagi Grimberg wrote:
> In tcp.c:
> --
> static void nvme_tcp_set_sg_inline(struct nvme_tcp_queue *queue,
>                 struct nvme_command *c, u32 data_len)
> {
>         struct nvme_sgl_desc *sg = &c->common.dptr.sgl;
> 
>         sg->addr = cpu_to_le64(queue->ctrl->ctrl.icdoff);
>         sg->length = cpu_to_le32(data_len);
>         sg->type = (NVME_SGL_FMT_DATA_DESC << 4) | NVME_SGL_FMT_OFFSET;
> }
> 
> static void nvme_tcp_set_sg_host_data(struct nvme_command *c,
>                 u32 data_len)
> {
>         struct nvme_sgl_desc *sg = &c->common.dptr.sgl;
> 
>         sg->addr = 0;
>         sg->length = cpu_to_le32(data_len);
>         sg->type = (NVME_TRANSPORT_SGL_DATA_DESC << 4) |
>                         NVME_SGL_FMT_TRANSPORT_A;
> }
> --
> 
> What is the sgl type you see in the traces? transport specific sgl
> (host-data i.e. non-incapsule) or inline?

The Sub Type is 0xA, Transport Specific.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
