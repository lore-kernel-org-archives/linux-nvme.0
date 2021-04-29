Return-Path: <SRS0=qX5s=J2=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E0C3C433B4
	for <linux-nvme@archiver.kernel.org>; Thu, 29 Apr 2021 03:24:52 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 767A161448
	for <linux-nvme@archiver.kernel.org>; Thu, 29 Apr 2021 03:24:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 767A161448
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=MGDTyzPQRKYRAq/cAJhcMAUzxRSNF+E7Kg1FMbaVWuY=; b=Fx1RICSR4ewe+UrU8liPktpHe
	7jvZhJphnVr+S9h4SJL5DJYbgWA4BJPzFyRQtjZ8LdmRLcqFDH7DNSI1Inaa0DR71Q1LOTzu4bQHn
	Uzl+GF5GERT37FKu3868VsjAbXBr4gXtm91lZCRQV/1D73y/4Do6GGDn0ppPSvYMh8fl3RlioKpRK
	4CTwLhI2Qa+qF5wvMjSkZ/CQKWHJNSMrpIsS10ARFDRb908KWrT+wfQxcIKWF+zNkz4q6WkUDUJSo
	mgbn067izErLWULZw85AXTm+rfSwLN6f0W7gbht3sHlIp7xkZ5pgAB8/o2+RSTmjamVIALOe0fVCU
	lFSBKz3Iw==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lbxHx-004lnH-AJ; Thu, 29 Apr 2021 03:24:29 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lbxHR-004llc-KO
 for linux-nvme@desiato.infradead.org; Thu, 29 Apr 2021 03:24:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=tei7HjgP3a7IU725q6LLCJSNMjk/qn1LI3yw0n0wm2M=; b=qZctjaeJ5udqMy/KXcIePllsFN
 F6h+8T7cXvKw8Bo2ZhVabK/bm79zhKgA5e5ZLfJCI53pk9e1sgbAcMBip7KHk9pGqjN/m6FTwFDCx
 Nr8sBufiVCJLpViVn3crVVJsswsCg4txWIce2+Ne63FkEujqOUrN8HPoCiRHKQ8RDz3pydrGjioAf
 Cg3PSuZKxIDaH5poL1dSi+Di5d8gNYBLLKm8bwk+RHrc22bWla/vG/ECs3gHdxeyKIcOwGqt1UA9N
 xf+IZFZwvs9n7QmZDp56FrjbiUEXgnZ4cC3M1q1kB+ffZte97btYGNAc81U+hLnx5YTpCK5dZ6vLt
 m2vKOjRQ==;
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lbxHO-000LEU-OX
 for linux-nvme@lists.infradead.org; Thu, 29 Apr 2021 03:23:56 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id C5BDF61448;
 Thu, 29 Apr 2021 03:23:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1619666634;
 bh=d3cMFMIPhe+Ddzw763a95GISupl2Fy9jM+GEt/4xluQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=qh3VtifJP6yZDPSIB+u9TlEM7JHcF+g45syTkbqjlHbk3mNVd1eNs+S7xV49A7uhg
 xdAWXXRlOYmFn6klQkOFnbtaXefRKInYRUQBPfxpZfvpMY0sLiDDL/+mPBwDcb9f8T
 +WuJ7EccG9bCDNhs0VyKrXyrJJyjwQyclC7g5E/r4HJeWL9WhxGIZGqIq7UBdIclLU
 f2jXrnIWew1/uFEqUY1OIZFBFkuM5eCtn4HTFrCUeJflnwitPdWwJUhSgIMNI6Owrk
 egbkBIALpuw7B+lu6m6Hfu4BFgxUIW7K6MFENcLIwIk6AAN+lc+KPc4fqSS5roKyAf
 i3cOfVJBAIFqw==
Date: Thu, 29 Apr 2021 12:23:51 +0900
From: Keith Busch <kbusch@kernel.org>
To: Yi Zhang <yi.zhang@redhat.com>
Cc: linux-nvme@lists.infradead.org
Subject: Re: [bug report]unhandled identify cns 6 on qid 0
Message-ID: <20210429032351.GB24074@redsun51.ssa.fujisawa.hgst.com>
References: <CAHj4cs9o9+CkkZk3JUrgr=-D+ExBYdzLFxwD2fJ+_NxkvGyD4Q@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAHj4cs9o9+CkkZk3JUrgr=-D+ExBYdzLFxwD2fJ+_NxkvGyD4Q@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210428_202354_838446_CCD32EDE 
X-CRM114-Status: GOOD (  13.39  )
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

On Thu, Apr 29, 2021 at 09:44:05AM +0800, Yi Zhang wrote:
> Hi Keith
> I found this error log during blktests[2] on linux-block/for-next, it
> was introduced with [1] and seems no handler for NVME_ID_CNS_CS_CTRL,
> could you help check it?

Thanks for the report.

Just to confirm: the only problem is that a new error has been logged,
but the test passes otherwise, correct? If yes, I believe the error
message is harmless, but I will look into suppressing it because these
are alarming, and it is not a target error when a host requests an
unsupported identification anyway.

 
> [1]
> commit 5befc7c26e5a98cd49789fb1beb52c62bd472dba
> Author: Keith Busch <kbusch@kernel.org>
> Date:   Wed Mar 24 16:18:05 2021 -0700
> 
>     nvme: implement non-mdts command limits
> 
> 
> +       c.identify.cns = NVME_ID_CNS_CS_CTRL;
> 
> static void nvmet_execute_identify(struct nvmet_req *req)
> {
>         if (!nvmet_check_transfer_len(req, NVME_IDENTIFY_DATA_SIZE))
>                 return;
> 
>         switch (req->cmd->identify.cns) {
>         case NVME_ID_CNS_NS:
>                 return nvmet_execute_identify_ns(req);
>         case NVME_ID_CNS_CTRL:
>                 return nvmet_execute_identify_ctrl(req);
>         case NVME_ID_CNS_NS_ACTIVE_LIST:
>                 return nvmet_execute_identify_nslist(req);
>         case NVME_ID_CNS_NS_DESC_LIST:
>                 return nvmet_execute_identify_desclist(req);
>         }
> 
>         pr_err("unhandled identify cns %d on qid %d\n",
>                req->cmd->identify.cns, req->sq->qid);
> 
> [2]
> #./check nvme/010
> [  493.632730] run blktests nvme/010 at 2021-04-28 04:19:28
> [  493.669330] loop0: detected capacity change from 0 to 2097152
> [  493.685798] nvmet: adding nsid 1 to subsystem blktests-subsystem-1
> [  493.689397] nvmet: creating controller 1 for subsystem
> blktests-subsystem-1 for NQN
> nqn.2014-08.org.nvmexpress:uuid:48741e3a-3c7e-428b-877f-b78897ab0f61.
> [  493.689439] nvmet: unhandled identify cns 6 on qid 0
> [  493.694412] nvme nvme0: creating 32 I/O queues.
> [  493.695351] nvme nvme0: new ctrl: "blktests-subsystem-1"
> [  497.870910] nvme nvme0: Removing ctrl: NQN "blktests-subsystem-1"
> 
> Thanks
> Yi
> 

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
