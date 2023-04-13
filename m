Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BE7EC77B6E
	for <linux-nvme@archiver.kernel.org>; Thu, 13 Apr 2023 10:49:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=VwolWxqxRA9MdFhR3rLHQ8MzSN5ZvGkLITOCzAeLmXs=; b=zd+/sPpaKn7I9pUVoaKX6tQ2pK
	F6ZNUTW09T0zoe6b1MndA4Pqj6+nec6+HZV9wwUydC3RD3rnRzL5AffIkGNx6WkgXEpbGQjVSEiH/
	sStO78wwoBV3pV9UmQI3GId8PTsKL6gDa4qGy2o7XlDZoEVRr+dYX1ygycO4eGRAJOk/ZimDGPYRJ
	z6Z4rdgnyftIru+aO7wn5qSEvbu8w3f5q2jBUtMr514BcYeZ28CESb3lia+kymxMeLEndRQLOoCwd
	ikFQNBCI8+tEay53IgG7nq9Fdhyn4+8YGoY71WMPlwHKa7JNFKJRftqhWoptjqYG3abXtT9I5EQGt
	Q5E7v2Cg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pmuWS-005vzs-1X;
	Thu, 13 Apr 2023 10:49:48 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pmuWP-005vxj-1y
	for linux-nvme@lists.infradead.org;
	Thu, 13 Apr 2023 10:49:46 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 8FCA963D2E;
	Thu, 13 Apr 2023 10:49:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78A90C433D2;
	Thu, 13 Apr 2023 10:49:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1681382984;
	bh=jsc/dnmYYYhpaGc2p6sjW2b9HrbEdz6s45EOnqUkmKc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=meerZEh6SswwFZ+RpOqwyUiOxedfXkpFPFcQscZllf3wGkjqDKfnFytAJYqBaOV/X
	 FIhnuubKJB2CH7QWFzTutxJeZbp8zdcxYSuYE23Phf7QjaJjJmObK+Ngb595sXygWc
	 3P8XVpcuhWv5gNkatsMXN6UJKlo7mzM8ztZxdx6wcczSAFve68biX9GezriZNAyp+L
	 vED+1xLq9gPSdfQdJYYmHSV+JvmkFvylgJjtnBUXZ83wZ1hU8FA6kPpI/y7BXLWXDi
	 p9hB3URzgB1zysZ9dyt45RiSqon59NzM+fKOwJUhllB+YKQ4+OXekB0IWFTY1+2q9a
	 Qc2rV7JpXEOQQ==
Message-ID: <2a464237-975a-bfaf-ef2f-15ffd45b4d8a@kernel.org>
Date: Thu, 13 Apr 2023 19:49:42 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: WTF is going on with the nvme-cli build
Content-Language: en-US
To: Daniel Wagner <dwagner@suse.de>, Christoph Hellwig <hch@infradead.org>
Cc: linux-nvme@lists.infradead.org
References: <ZDemsiJi5vXd6aia@infradead.org>
 <4jstzssirve7hiaimj6fm52rftqadwo2tmnjx62zq7lzkrjkfw@ooh4zluxlrrd>
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <4jstzssirve7hiaimj6fm52rftqadwo2tmnjx62zq7lzkrjkfw@ooh4zluxlrrd>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230413_034945_693318_22E59C91 
X-CRM114-Status: GOOD (  20.44  )
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

On 4/13/23 16:07, Daniel Wagner wrote:
> Hi Christoph,
> 
> On Wed, Apr 12, 2023 at 11:52:34PM -0700, Christoph Hellwig wrote:
>> can you please urgently fix nvme-cli to have a sane build system
>> again?
> 
> Please, let's not be so drastic and I would argue all build system have their
> wards. We just need to figure out how to handle them.

Since we are talking about this, builds of libnvme on latest Fedora miserably fail:

FAILED: src/libnvme.so.1.4.0.p/nvme_json.c.o
ccache cc -Isrc/libnvme.so.1.4.0.p -Isrc -I../src -I. -I.. -Iccan -I../ccan
-Iinternal -I../internal -I/usr/local/include/json-c -fdiagnostics-color=always
-D_FILE_OFFSET_BITS=64 -Wall -Winvalid-pch -std=gnu99 -O0 -g
-fomit-frame-pointer -D_GNU_SOURCE -include internal/config.h
-DCCAN_LIST_DEBUG=1 -DCCAN_STR_DEBUG=1 -fPIC -MD -MQ
src/libnvme.so.1.4.0.p/nvme_json.c.o -MF src/libnvme.so.1.4.0.p/nvme_json.c.o.d
-o src/libnvme.so.1.4.0.p/nvme_json.c.o -c ../src/nvme/json.c
../src/nvme/json.c:15:10: fatal error: json.h: No such file or directory
   15 | #include <json.h>
      |          ^~~~~~~~

All the time... And I do have the json development headers installed:

/usr/include/json-c/json.h

But the compile command does not add -I/usr/include/json-c: it uses the broken
default /usr/local/include/json-c. No normal distro install anything in
/usr/local...

And that is despite the fact that meson setup says:

Run-time dependency json-c found: YES 0.15

Something is not right.

> 
>> Right now it tries to download random packages over the internet
>> instead of not building components or failing the configuration.
> 
> Which version are you using? I've recentely change the default behavior of the
> fallback mechanisme but might have missed something. Alternatively, it also
> possible to change the global default for this feature.
> 
> The flag in question is:
> 
>   meson setup --wrap-mode=nofallback .build
> 


