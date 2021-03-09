Return-Path: <SRS0=pxZf=IH=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89486C433DB
	for <linux-nvme@archiver.kernel.org>; Tue,  9 Mar 2021 15:05:48 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0243765243
	for <linux-nvme@archiver.kernel.org>; Tue,  9 Mar 2021 15:05:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0243765243
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=M4DYVL3gl10XqFnDDFBn7KrDj/i31rWp5Sn65HtZLBc=; b=RilPJnYUE/g7eH76GjGUfsgcL
	oXdJvuUbhoeTC/TpWad4W2lLGCCRhoGrhBNnrGfPh9aCZOvyTitra6jImwT5+4M4MhMsMCS5M1NsV
	SN+jb1grEmTA076JqonburmP7vSJ2Eu1tUNzfSjp9vxpYmpstwmsHUmeQy6cQTsORYNq+CP3m/a6o
	cfpsNPMcw3AoRBzkONjpryRwOu3hP8gsII8ndFGY1+5gTSzAc3UGG+nnZdplrd9UEe7bBZ6H7Lwcj
	PUJeJAyAkTLN3q69zMoMHWOAtQ8+m9b3DjV3zy80FOWT8pJhObJ2rwK70E9g1PkPeE9FytIVVDeI9
	3I88hFRXw==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lJdvV-004ubb-BF; Tue, 09 Mar 2021 15:05:37 +0000
Received: from verein.lst.de ([213.95.11.211])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lJdvR-004uat-HL
 for linux-nvme@lists.infradead.org; Tue, 09 Mar 2021 15:05:35 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 2C9B168B05; Tue,  9 Mar 2021 16:05:31 +0100 (CET)
Date: Tue, 9 Mar 2021 16:05:31 +0100
From: Christoph Hellwig <hch@lst.de>
To: Javier =?iso-8859-1?Q?Gonz=E1lez?= <javier@javigon.com>
Cc: Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org, kbusch@kernel.org, sagi@grimberg.me,
 minwoo.im.dev@gmail.com
Subject: Re: [PATCH V6 1/2] nvme: enable char device per namespace
Message-ID: <20210309150531.GA15052@lst.de>
References: <20210301192452.16770-1-javier.gonz@samsung.com>
 <20210301192452.16770-2-javier.gonz@samsung.com>
 <20210303091022.GA12784@lst.de>
 <20210303100212.e43jgjvuomgybmy2@mpHalley.localdomain>
 <20210309113103.GA9233@lst.de>
 <20210309124104.uowad6bd4vlcthmw@mpHalley.local>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210309124104.uowad6bd4vlcthmw@mpHalley.local>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210309_150533_760061_27254C82 
X-CRM114-Status: GOOD (  15.15  )
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
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Tue, Mar 09, 2021 at 01:42:23PM +0100, Javier Gonz=E1lez wrote:
>> - nvme_cdev_fops implements file operations that directly on a nvme_ns,
>>   so they are path specific
>
> This is correct.
>
>> - we allow opening them even for a hidden controller
>
> This is also correct.
>
>> - there does not seem to be a char device node for ns_head at all.
>
> Also correct.
>
> We tried to keep it simple in the first iteration. Am I understanding
> that you see necessary to have per ns_head char devices?

That would be my understanding of "multipath support" for this character
device, yes.  Especially as hiding the individual char devices for the
hidden controllers once they are initially exposed would be an ABI break.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
