Return-Path: <SRS0=f1uU=ZY=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58308C432C0
	for <linux-nvme@archiver.kernel.org>; Mon,  2 Dec 2019 16:27:21 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1ECFE20722
	for <linux-nvme@archiver.kernel.org>; Mon,  2 Dec 2019 16:27:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="uoMbo9M8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1ECFE20722
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=dRYgdv0EqV1eBZR0iUPlZB33W39P4NJaQn/WjNC9KxA=; b=uoMbo9M8Fp6xV77s3WSxfPtNb
	bTNcXRwuEiI0az1itTWvApZyKbzURdQjAuC0s2w/WVMNQ+u/g34uHCUYNFWkiIntA/PR45HucE8/a
	2GzVp0SarEihJS1SOjadG6vQghOas8eVReFMZ8xK4IGpWW+uJJZs5VOKEsdNhopoAn+tbHE0tWm4a
	UpI9XAk76qWH6q6IwZmVSKD7BFUjzzzbVE5kzzcCMeU/0cRX1o8ulSA+KeWvcMWCDB+XzSnz2Gfus
	Loiy9NKKWe0ShKktpyShq7Wi8CKANpc/HNQJJaayS5+55ks7GU3vtkJp0OlGpB9F/Q4DtUWrycS8m
	o5JzzjqEA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1iboXe-0005VE-7P; Mon, 02 Dec 2019 16:27:18 +0000
Received: from mga11.intel.com ([192.55.52.93])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iboXb-0005UP-MC
 for linux-nvme@lists.infradead.org; Mon, 02 Dec 2019 16:27:17 +0000
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
 by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 02 Dec 2019 08:27:15 -0800
X-IronPort-AV: E=Sophos;i="5.69,268,1571727600"; d="scan'208";a="208138887"
Received: from unknown (HELO [10.232.112.32]) ([10.232.112.32])
 by fmsmga008-auth.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-SHA;
 02 Dec 2019 08:27:14 -0800
Subject: Re: [PATCH] nvme: Namepace identification descriptor list is optional
To: Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>
References: <20191202155611.21549-1-kbusch@kernel.org>
 <20191202161545.GA7434@lst.de>
 <20191202162256.GA21631@redsun51.ssa.fujisawa.hgst.com>
From: "Nadolski, Edmund" <edmund.nadolski@intel.com>
Message-ID: <10e6520d-bc8c-94ff-00c4-32a727131b89@intel.com>
Date: Mon, 2 Dec 2019 09:27:14 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191202162256.GA21631@redsun51.ssa.fujisawa.hgst.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191202_082715_734743_9E453826 
X-CRM114-Status: GOOD (  16.17  )
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
Cc: Ingo Brunberg <ingo_brunberg@web.de>, linux-nvme@lists.infradead.org,
 Sagi Grimberg <sagi@grimberg.me>, stable@vger.kernel.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 12/2/2019 9:22 AM, Keith Busch wrote:
> On Mon, Dec 02, 2019 at 05:15:45PM +0100, Christoph Hellwig wrote:
>> On Tue, Dec 03, 2019 at 12:56:11AM +0900, Keith Busch wrote:
>> > Despite NVM Express specification 1.3 requires a controller claiming to
>> > be 1.3 or higher implement Identify CNS 03h (Namespace Identification
>> > Descriptor list), the driver doesn't really need this identification in
>> > order to use a namespace. The code had already documented in comments
>> > that we're not to consider an error to this command.
>> > 
>> > Return success if the controller provided any response to an
>> > namespace identification descriptors command.
>> > 
>> > Fixes: 538af88ea7d9de24 ("nvme: make nvme_report_ns_ids propagate error back")
>> > Reported-by: Ingo Brunberg <ingo_brunberg@web.de>
>> 
>> Why would we ignore the error?  Do you have a buggy controller messing
>> this up?
> 
> I don't have such a controller, but many apparently do. The regression
> was reported here:
> 
> http://lists.infradead.org/pipermail/linux-nvme/2019-December/028223.html
> 
> And of course it's the SMI controller ...

Does 5.4 show the exact error code?  Perhaps we should selectively allow just 
for that case?

Ed


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
