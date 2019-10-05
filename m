Return-Path: <SRS0=LrAE=X6=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A93C8C3E8AB
	for <linux-nvme@archiver.kernel.org>; Sat,  5 Oct 2019 14:48:19 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7C34820862
	for <linux-nvme@archiver.kernel.org>; Sat,  5 Oct 2019 14:48:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="p7Tglru8";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="q3JzzkP8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C34820862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ETqnBo87auhU66fBcGSsTnL3JlcRyrNgczLnthx68hQ=; b=p7Tglru8+VGkFb
	6pBm6gPq1OHHfg4MTFeR2EA7yMjsJhgxiHFaBF4YKHZeq1lRZjiWoUR3gMcwhyzR9eKf1mOEfGgrv
	SlPoNCX0aEXN0+1Z/ujKCgn/cXQHcRTzklkWpJNFm6Tb4Blc5VIdA4DF/jA4ozi+RwTXTK222hKA2
	F+4vwgFDvyPI9loxjJ7O8htr0Zd1Ym2iVtI1gqvT9HFmUs5DezN1sm1fYfoDgDWbvcEZiHmrys+DS
	cxZWy9zVveHG8eHskPXaQVeE93jrQ9qpGaiXSzVf1EcGmE+JimR+TYa9L4FqnCJc+xfQuNIhgj+Vi
	ELQJ5lzTch/LkfL7NZ5w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.2 #3 (Red Hat Linux))
	id 1iGlM0-00071L-Mp; Sat, 05 Oct 2019 14:48:16 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.92.2 #3 (Red Hat Linux))
 id 1iGlLy-000714-HT
 for linux-nvme@lists.infradead.org; Sat, 05 Oct 2019 14:48:15 +0000
Received: from keith-busch (unknown [8.36.226.102])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id F110820862;
 Sat,  5 Oct 2019 14:48:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1570286894;
 bh=mQvgIiL6Xzi6cECRFh3msnA/q2nSjb9ljQi1aRj74WI=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=q3JzzkP8gxk+NNM/x6muR+6XC+1DmW+UyjygWLYwuHAT/A5eFCZK82aCxvsDdKmks
 W0ek8Ksu99yOVxKN/Tx/Tii9VCIKOckE0nJSuug/0NdQ69JhSRihPjdqRPcj00mimk
 6dFkELCGrwqdrzQKEreEBisTH/uTEXM/7CVKFAos=
Date: Sat, 5 Oct 2019 08:48:12 -0600
From: Keith Busch <kbusch@kernel.org>
To: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Subject: Re: [PATCH] nvme: define struct for __nvme_submit_sync_cmd()
Message-ID: <20191005144811.GB30437@keith-busch>
References: <20191001231346.18518-1-chaitanya.kulkarni@wdc.com>
 <58CA8A6F-46B6-4728-9EF4-ED3EAEEEEE2E@javigon.com>
 <BYAPR04MB5749A393F5328589B36CDE36869C0@BYAPR04MB5749.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <BYAPR04MB5749A393F5328589B36CDE36869C0@BYAPR04MB5749.namprd04.prod.outlook.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191005_074814_602940_CE4DA46E 
X-CRM114-Status: UNSURE (   9.45  )
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
Cc: Javier =?iso-8859-1?Q?Gonz=E1lez?= <javier@javigon.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Wed, Oct 02, 2019 at 06:10:09AM +0000, Chaitanya Kulkarni wrote:
> On 10/1/19 10:47 PM, Javier Gonz=E1lez wrote:
> > Makes sense to me. We have other places with similar arguments (e.g.,
> > nvme_submit_user_cmd). Would it make sense to unify this too if we move
> > in this direction?
> > =

> Thanks for the feedback, I'll add that too in the next version.

It also looks like much of the callers can use the much simpler
nvme_submit_user_cmd() that already provides defaults to the numerous
parameters.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
