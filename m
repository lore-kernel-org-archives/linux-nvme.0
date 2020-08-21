Return-Path: <SRS0=kXjr=B7=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2A40C433E1
	for <linux-nvme@archiver.kernel.org>; Fri, 21 Aug 2020 07:49:23 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 708A720738
	for <linux-nvme@archiver.kernel.org>; Fri, 21 Aug 2020 07:49:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="g1M3AIco"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 708A720738
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=aoPRkoilMsofKBVBoo7+oCs63Nq31d/0ZJWFPptQT8o=; b=g1M3AIcoLa1ab0Guw14qRn9I9
	7YGI8evKfYFHcDTE/JFfwUv5fElzoJmzt2tjTQnJ1/JflUlEADHRaq2lYrDUl8rwgAsKPsAshMgOj
	UK30FKhwMcXu8b6/2Y2DjLxwGNrTGxsAYihWXmx83ESFTqpmXlpKVO5GyOfBJoMBEtuawvM1xW0/R
	Huj2hgr5KFs+U2fC6hGAv6xrAoakgxRTowjJx526hiXeLdqUsdi1AV3xQWUJM6hNdrpVYxkfhfW1B
	gpZ83QxVJQ+hZIU5yHdTiVyByvlZqkTh1c7LAyoV0a6+4KdUc0oIn+dTYlcKbqFv+dWzqaDknAWUq
	S+Svdw7Vw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k91nZ-0001lA-3t; Fri, 21 Aug 2020 07:49:17 +0000
Received: from verein.lst.de ([213.95.11.211])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k91nV-0001ko-St
 for linux-nvme@lists.infradead.org; Fri, 21 Aug 2020 07:49:14 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id AA26268AFE; Fri, 21 Aug 2020 09:49:10 +0200 (CEST)
Date: Fri, 21 Aug 2020 09:49:10 +0200
From: Christoph Hellwig <hch@lst.de>
To: Chao Leng <lengchao@huawei.com>
Subject: Re: [PATCH 3/3] nvme-core: fix crash when nvme_enable_aen timeout
Message-ID: <20200821074910.GA30216@lst.de>
References: <20200820035413.1790-1-lengchao@huawei.com>
 <fc1efcce-99d9-05cf-5f32-9c454e3b0efe@grimberg.me>
 <820d5867-3e44-a009-d6b5-ea1a3fecd037@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <820d5867-3e44-a009-d6b5-ea1a3fecd037@huawei.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200821_034914_080143_E897CDBD 
X-CRM114-Status: GOOD (  13.23  )
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
Cc: axboe@fb.com, Sagi Grimberg <sagi@grimberg.me>,
 linux-nvme@lists.infradead.org, linux-block@vger.kernel.org, kbusch@kernel.org,
 hch@lst.de
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Thu, Aug 20, 2020 at 02:43:20PM +0800, Chao Leng wrote:
>>> -static void nvme_enable_aen(struct nvme_ctrl *ctrl)
>>> +static int nvme_enable_aen(struct nvme_ctrl *ctrl)
>>> =A0 {
>>> =A0=A0=A0=A0=A0 u32 result, supported_aens =3D ctrl->oaes & NVME_AEN_SU=
PPORTED;
>>> =A0=A0=A0=A0=A0 int status;
>>> =A0=A0=A0=A0=A0 if (!supported_aens)
>>> -=A0=A0=A0=A0=A0=A0=A0 return;
>>> +=A0=A0=A0=A0=A0=A0=A0 return 0;
>>> =A0=A0=A0=A0=A0 status =3D nvme_set_features(ctrl, NVME_FEAT_ASYNC_EVEN=
T, supported_aens,
>>> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 NULL, 0, &result);
>>> -=A0=A0=A0 if (status)
>>> +=A0=A0=A0 if (status) {
>>> =A0=A0=A0=A0=A0=A0=A0=A0=A0 dev_warn(ctrl->device, "Failed to configure=
 AEN (cfg %x)\n",
>>> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 supported_aens);
>>> +=A0=A0=A0=A0=A0=A0=A0 if (status < 0)
>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return status;
>>
>> Why do you need to check status < 0, you need to fail it regardless.
>
> agree.
> Just want to keep the old logic. I guess the old logic: if supported_aens
> is true, the result of set features can ignore.
>
> If there is no objection to doing so, I will resend the patch later.

In the past we've dedice to ignore real NVMe errors in various
spots as the functionality wasn't deemed critical.  I think that is
pretty sloppy and we should only do that where we really have to.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
