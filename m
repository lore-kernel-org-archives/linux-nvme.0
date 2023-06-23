Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CF18EB64D7
	for <linux-nvme@archiver.kernel.org>; Fri, 23 Jun 2023 22:34:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=FdHBxcyFWQtCipLFysDTiTg2Vc1TA6ufxVai8DyGPQM=; b=IhZtnQ9LOglzYAZRB7/jGLawJ0
	qO4u383GZXop77whjU2p4DmtCy3Z4JMhkutV9uOeuu6Nnvpm3RrHV2zEzkIZ90k6pXnqoij8pTNC8
	Qqj4QeYhMaWfLRMPXcJz56LTzSeqco5r+YrOSoXwLFeYXRShOWHegqggZ0cHAExU+qacrzTEhrgtv
	dNaovUlkttnkl2w0naAp2we8s3M/0qdMzTeXHoXDfx4gOy6itQVM0HRIka7n8bVwtHDDce/Un4lij
	o5qlZ15nwhVZwWInLTByeBuyrBAAs4NE/9wJSgd8ZuaY83ZOp+est1hefZIhYQBSsWIoThV6u9eXt
	RBF1lE2w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qCpMZ-004lTY-0o;
	Fri, 23 Jun 2023 22:34:43 +0000
Received: from mail-wr1-f41.google.com ([209.85.221.41])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qCpMW-004lSW-0f
	for linux-nvme@lists.infradead.org;
	Fri, 23 Jun 2023 22:34:42 +0000
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-313de8a0037so98181f8f.0
        for <linux-nvme@lists.infradead.org>; Fri, 23 Jun 2023 15:34:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687559678; x=1690151678;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FdHBxcyFWQtCipLFysDTiTg2Vc1TA6ufxVai8DyGPQM=;
        b=Z+kUBoSSYWZv9kj4ehyt4i5+g2nRN9g7lqfplPL99TahU72lxzl0Qgq7CYjGDmnbVo
         JPKAnE74ZOTstefsqS74azS7YoKPFQMxgGaMsFFLodsD6kBfv417v1ANSsQA25ZMdJ49
         bhy7KNDLvVpEUeLNitUo1z6ARcHcZaR7Irpj4ETWYsrh00yQlWFohmKrT11LZG0QomgJ
         mSuROkOmZcgLt5gcJCAmYRDbAx/J5k18lXogaA8U63Zi3UWvr/xcVCRZtz27nyDsKIcx
         dmNAMeg6u1BVV1bH/j9WzMMHw9SGw0T12SuERGlOKGde+p7xqbo8atbHs9o0JHsJADyV
         s72g==
X-Gm-Message-State: AC+VfDwi9SSEr1yz9S+Ehc+lAM7l2NQv/at3n4Cai+2L5P4j2O2LqMg6
	2VdoZfFg4HToyZbfhUM+VX4=
X-Google-Smtp-Source: ACHHUZ4gZFgjg4KgcDKH1DVOpG1eulgvvCtb29JjT+7mtEglIFjnRppXg/5JlGu/EuyauL/D4/2y/w==
X-Received: by 2002:a5d:4811:0:b0:305:ed26:856e with SMTP id l17-20020a5d4811000000b00305ed26856emr18281999wrq.4.1687559677373;
        Fri, 23 Jun 2023 15:34:37 -0700 (PDT)
Received: from [10.100.102.14] (46-116-229-137.bb.netvision.net.il. [46.116.229.137])
        by smtp.gmail.com with ESMTPSA id l13-20020a5d674d000000b003113513f491sm463730wrw.114.2023.06.23.15.34.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Jun 2023 15:34:36 -0700 (PDT)
Message-ID: <227cde76-8283-9313-f618-d35fcd6b7881@grimberg.me>
Date: Sat, 24 Jun 2023 01:34:34 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: What's the upstream disposition with nvme-stas?
Content-Language: en-US
To: John Meneghini <jmeneghi@redhat.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>
Cc: "smith, erik" <Erik.Smith@dell.com>, "Rose, Charles"
 <Charles.Rose@dell.com>, "Belanger, Martin" <Martin.Belanger@dell.com>,
 Hannes Reinecke <hare@suse.de>, Martin Wilck <mwilck@suse.com>,
 Daniel Wagner <dwagner@suse.de>
References: <b7f6bba3-30b0-8d55-e285-b922101a04f4@redhat.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <b7f6bba3-30b0-8d55-e285-b922101a04f4@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230623_153440_248396_417ECAD8 
X-CRM114-Status: GOOD (  54.06  )
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
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


> Christoph, Sagi, Keith, et al,

Hey John, and others,

> There has been an ongoing series of 3-way private conversations about 
> the status of nvme-stas and I am sending this email to put these 
> conversations into the public.
> 
> Background:
> 
> If my memory serves me correctly: after several failed attempts to add 
> an "NVMe/TCP auto-discovery" feature to Linux by leveraging an avahi 
> based mDNS/SD mechanism (one by Sagi, circa 2018, and one by Martin 
> Wilck, circa 2021) TP-8009/8010 was created at NVMexpress.org. At that 
> time Martin Belanger asked Keith Busch for a repository in the 
> linux-nvme domain on Github and nvme-stas was born. My understanding was 
> that the goal of the nvme-stas repository was to stage the nvme-cli code 
> changes that would be needed to eventually support TP-8009/8010. While 
> some of that work has been done and nvme-cli now supports TP-8010 
> compliant discovery controllers (e.g. with the addition of the nvme dim 
> - Send Discovery Information Management - command) there is still much 
> functionality in nvme-stas that has not been merged into nvme-cli, 
> including the mDNS/SD based functionality needed to support TP-8009. 
> This remaining nvme-stas functionality, and the status of any effort to 
> merge it into nvme-cli, is the source of all the private conversations 
> and debates.

I don't think we want the two to merge the two. nvme-cli is a cli, and
nvme-stas is a daemon designed to support TP-8009. Don't think we should
expect to have one single tool to do everything...

> Current Status:
> 
> At LSFMM this year I spoke with privately with Keith Bush and others 
> about the status of nvme-stas. When Keith and I spoke he told me that 
> Dell had talked with him privately about nvme-stas and asked if the 
> nvme-stas functionality can be merged into nvme-cli or otherwise 
> accepted upstream.  Keith said that he told Dell, after looking at the 
> nvme-stas implementation (again), the answer was no.

I agree with his answer.

> When I spoke with Hannes about nvme-stas he agreed with me that the 
> utility is, at best, a stop-gap solution and that we need to continue to 
> look for a better solution to the "NVMe/TCP auto-discovery" problem. We 
> brain stormed about implementing an nvme-tcp discovery listener socket 
> in Linux that leverages the Kickstart Discovery Request (KDReq) PDU from 
> TP-8010.  We also brainstormed about this topic at the 2022 ALPSS 
> conference last October.

It is not clear to me that an alternative tool would merge into nvme-cli
either. It's also not clear to me that users would benefit from
packaging the two together. But I've yet to see anything else.

> I think people in the upstream community are 
> aware that some improvements with NVMe/TCP discovery are needed, but 
> nobody, that I am aware of, see's nvme-stas as a solution to the 
> problem. Nobody really cares about nvme-stas...

I cannot comment about weather nvme-stas is a proper solution or not,
because I don't know.

I agree that anyone outside of Dell (along with their users) probably
doesn't care about it too much, simply because it is not supported or
used by anyone else to the best of my knowledge.

If more vendors/solutions/projects start using nvme-stas then this would
naturally change. But we'll have to wait and see if that ends up being
the case.

> but then that's the 
> purpose of this email. I want to stop talking about what other people 
> think.  They can speak for themselves. And if we are going to talk about 
> the short comings and problems with nvme-stats, let's do that publicly, 
> not privately.  I am tired of the hear-say game that happens with 
> private conversations.
> 
> So what's the debate?
> 
> I work for Red Hat and Dell has asked Red Hat to support nvme-stas as a 
> Red Hat product. Red Hat is not inclined to do this because we currently 
> support discovering and managing all nvme and nvme-of devices with the 
> nvme-cli utility and we don't want to support two different utilities to 
> do this. Our general policy at Red Hat is: upstream first.  We don't 
> want to support any package or feature that is not first supported 
> upstream. So the push back from Red Hat to Dell, privately, has been: 
> please get your nvme-stas functionality merged into the nvme-cli utility 
> upstream. This is the source of all the three way private conversations 
> with Dell and everyone else. Anyways, at this point it looks like a 
> complete merge of nvme-stas with nvme-cli is not going to happen, so if 
> there is any conversation about why or how or what needs to be done to 
> change that, let's have that conversation here.

I'll reiterate what Keith said, I don't think it should be our business
if a distro chooses to support any tool or not. This is solely between
Dell and RedHat.

AFAIK, nvme-stas is an open-source project, that implements TP-8009
and supports Dell products. I personally don't have any opinion about
it either way.

> So what does "supported by" mean any way?
> 
> I believe the goal of the upstream linux-nvme project is to support one 
> general purpose Linux utility used for discovering and managing nvme and 
> nvme-of devices. This is the nvme-cli utility. This is what's "supported 
> upstream" and I'd like to end any debate about whether or not the 
> upstream community supports nvme-stas. Nvme-stas is supported by the 
> upstream community to the extent that it uses the kernel and libnvme 
> APIs to access nvme devices; just as any other third party user space 
> application that exploits these kernel and user space APIs is supported.
> Other than this, nvme-stas is not "supported upstream".

I agree with Keith's response. nvme-stas is a perfectly legitimate
open-source tool that is backed by Dell (pretty much only at this
point). It's neither is or isn't "supported upstream".

> Notwithstanding the fact that Dell's CDC is compliant the NVMe 
> specification, nvme-stas is arguably little more than a Dell specific 
> utility which is designed to optimize nvme-of discovery with Dell's 
> products. There are no upstream or open source CDC implementations 
> available (that I am aware of), and there are no commercial CDC 
> implementations available other than Dell's (that I am aware of). So, at 
> this point, nvme-stas's primary purpose is to optimize and enable the 
> special nvme-of discovery features of Dell's CDC product. With this 
> being the case, shouldn't nvme-stas be supported by Dell?  It was 
> written and designed by Dell to support their products. Until this 
> changes I really don't see why any entity other than Dell should be 
> called upon to "support nvme-stas".

Nothing should prevent others from supporting and leveraging nvme-stas,
the spec is open, and nvme-stas is open-source. Only time will tell
if others will.

> In summary:
> 
> - The linux-nvme project supports the kernel and library APIs 
> implemented in libnvme in support of the nvme-cli utility.
> - The linux-nvme project supports the nvme-cli utility for the general 
> purpose of managing nvme and nvme-of devices.
> - Anyone is free to contribute to libnvme and nvme-cli to the extent 
> that their contributions support this goal with nvme-cli
> - Projects like nvme-stas are free to use libnvme and nvme-cli to 
> support their specific use case,
>    but this does not mean their use case is supported by the upstream 
> linux-nvme project

If for example nvme-stas needs a capability from the driver, it would
need to make a reasonable argument to why this capability makes sense,
and how users can benefit generally in order to get it (otherwise the
answer will be "no"). This is not different from any other tool, open
or closed.

I would assume that the same holds for nvme-cli/libnvme.

> - It has been agreed that the remaining features and functions of 
> nvme-stas cannot be merged into or subsumed by nvme-cli
> - The upstream linux-nvme project neither approves of or disapproves of 
> nvme-stas and the URL of the nvme-stas project
>    on Github in the linux-nvme domain should not be seen as an 
> endorsement by the linux-nvme project.
> - The linux-nvme upstream community is aware of the problems with 
> NVMe/TCP discovery and we are searching for a solution.
>    We are also not sure we want to support mDNS/SD as a solution - 
> TP-8009 notwithstanding.
> 
> Finally, whether or not any utility like nvme-stats or is supported by 
> any Linux distribution is an independant business decision. These 
> business decisions and support statements stand apart from any support 
> statement made by the upstream linux-nvme project, and each Linux 
> distribution has their own separate policies and standards for 
> distributing and supporting Linux upstream packages, utilities, 
> functions and features. We can't assume support by one distribution == 
> support upstream == support by another distribution.

I think that we can summarize that there is "upstream nvme-cli",
"upstream libnvme" and also "upstream nvme-stas". the linux-nvme
community has different levels of interest in each.

