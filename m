Return-Path: <SRS0=6U9w=JQ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61640C433ED
	for <linux-nvme@archiver.kernel.org>; Mon, 19 Apr 2021 07:16:51 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2272861057
	for <linux-nvme@archiver.kernel.org>; Mon, 19 Apr 2021 07:16:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2272861057
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=XN5JHjyxWTa6K0UJA8QiZ4nvCq1YBQh19YzgtIo47sc=; b=jLKBu0dsFTqd3VSv1lG5xXDhz
	KDVT/J2eTzohTjfcFimnC902VSsYlxPlwB4E2IzhkaN6BzHRBUWRCRHpQ7ilvBLEQO0H/MpgmEqLn
	2HBzJxdxdZqwk+/nGETQoIBtUhReC2ZGGP3CDvf1HTDzuZRSGekQjsM4g2JM8f17ADkXord6iVjo8
	1RnLOk1Riygu1rRLuW6OnCrIlk4SMI9E0GllsX/B3OvA0+2C5aNNGOy7BOtbz81YVMQek4lAKkw2t
	af/k3/4Aag2p9b+yWvOiUSx9y3tbkVx0hxaaibal5hIfrCssW9RHkP4XNWJNldnZTAZ3KpupO1o/y
	CIMl6/Ijw==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lYO8u-009JFO-32; Mon, 19 Apr 2021 07:16:24 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lYO8h-009JER-EV
 for linux-nvme@desiato.infradead.org; Mon, 19 Apr 2021 07:16:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=HvFY3PNcorYT1D8KVt3esPkiFQTL5l/BAS2WfxVUseA=; b=wgGEo2z3Pm8Z9+fMzQ3ibvJCVB
 I0NMsaBXZq8ntYhEbTEoftcPkuNWKYwclST00PnufMsvbnkE5CTRVUe/oy3iP6i8pWvRy3n3/HC5s
 qcmVkE6BZuBjI6BxAfTdPM9Dgw6q9P44EntntXljhhfl+H2DA0zskzPqojTA7vJ2ZSMAyo+ltfWwt
 2rcsFxwcH1N03b+5TSrDnOxBka++WMAvdIzIjRirsjJ1Bn9yXnc8JrqH5BXpwUkitI6ero0O9kDlV
 x44XQFo/C1N04PuZz9hmXKB+Krc/rCWdFs3NfExMSHHL3aPg0o2oR138KlX+IazVZy1K8xCnng2iq
 2nzzL9Hw==;
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lYO8e-00B7DN-SZ
 for linux-nvme@lists.infradead.org; Mon, 19 Apr 2021 07:16:10 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 96BDD68B05; Mon, 19 Apr 2021 09:16:05 +0200 (CEST)
Date: Mon, 19 Apr 2021 09:16:05 +0200
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>
Cc: Yuanyuan Zhong <yzhong@purestorage.com>, linux-nvme@lists.infradead.org,
 sagi@grimberg.me, hch@lst.de, axboe@kernel.dk, linux-block@vger.kernel.org
Subject: Re: [PATCH 2/2] nvme: use return value from blk_execute_rq()
Message-ID: <20210419071605.GA19658@lst.de>
References: <20210416165353.3088547-1-kbusch@kernel.org>
 <20210416165353.3088547-2-kbusch@kernel.org>
 <CA+AMecG=8TTdsdYtaV=H+hKm2poKYhyh_Tvf0Tc0PZvbVXf_iA@mail.gmail.com>
 <20210416171735.GA32082@redsun51.ssa.fujisawa.hgst.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210416171735.GA32082@redsun51.ssa.fujisawa.hgst.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210419_001609_087924_3BDB106E 
X-CRM114-Status: GOOD (  14.62  )
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

On Sat, Apr 17, 2021 at 02:17:35AM +0900, Keith Busch wrote:
> On Fri, Apr 16, 2021 at 10:12:11AM -0700, Yuanyuan Zhong wrote:
> > >         if (poll)
> > >                 nvme_execute_rq_polled(req->q, NULL, req, at_head);
> > You may need to audit other completion handlers for blk_execute_rq_nowait().
> 
> Why? Those callers already provide their own callback that directly get
> the error.
> 
> > How to get error ret from polled rq?
> 
> Please see nvme_end_sync_rq() for that driver's polled handler callback.
> It already has the error.

But it never looks at it..

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
