Return-Path: <SRS0=yPeo=GZ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C5F0C433E0
	for <linux-nvme@archiver.kernel.org>; Fri, 22 Jan 2021 07:37:35 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B3EA522DBF
	for <linux-nvme@archiver.kernel.org>; Fri, 22 Jan 2021 07:37:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B3EA522DBF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=cloud.ionos.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=OpBsMADv+Xdz2zKV2sJZbszV0gfgXt03m1/9hF5voqg=; b=w+fhHQMmPxCW3kKxdyRAckuQo
	IyEQF21UagYG6FX54J6+Q4x3W7XObHSPvBFo86++Chj303BFaYx3PdLDov6SUyDB2L8+tpcokDVit
	kGYjbicxUNOY8UjLJRHLG87djguUm4xUsXD2iK1BmZy8Q7c4M1ZAVNuhDWmv4duZUbxUKqJ3kVDKV
	YQ+rslKdo3TefFMob9OSwqT2GVWVIhtel9po6EOYyleVRjSj1DVFFpgbLLe8YcdcjzYVjfTTIv/4O
	uUEHYb7Nw8/b+Ekr/rVYYn9jm6mqfqAV4BxkfYK9yQBsd+Ll6m5/6SbuE2MNC9gFLA1g+9epVHs1S
	bTqFzLrDw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l2r0O-0001ep-TN; Fri, 22 Jan 2021 07:37:16 +0000
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l2r0M-0001e9-8i
 for linux-nvme@lists.infradead.org; Fri, 22 Jan 2021 07:37:15 +0000
Received: by mail-pf1-x436.google.com with SMTP id f63so3148697pfa.13
 for <linux-nvme@lists.infradead.org>; Thu, 21 Jan 2021 23:37:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cloud.ionos.com; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=xnObBx7qCVcq4Xmng0HzOiOYW//hrsobDgYRbXW2qoA=;
 b=dfhsrZgi1qJDI2m/ilO0UZ7ihv26w0btzlf1zmTicpi6ZJPqGMSAzlb7G4wGiF0FW3
 Gijmj6YCtu3PwTEsxPDNKVLwzNJfoZ+kzsARJbaXfKhjIPk0hIdEI6k7+iABd3J0Ge6o
 E21BaI1DVfxYzhQmtffSyiTWTX0ggTKcY1OLoksddvORRrvfQMQGbsphmp1xU/IKzC+G
 sD/zie7QvCQK1vih68EwWOxT3P4AOnndd/VBNtbw7iZsbzo+OPZQFBdc76x6uF8HLA4t
 egiWvXKCvt0EJ4zf4Nru3997s4IFCMrrcBcXNTQ8OpxxqBRXA3kIBOHmAEsIKhM9WxEA
 fFbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=xnObBx7qCVcq4Xmng0HzOiOYW//hrsobDgYRbXW2qoA=;
 b=e8bB8dW6laALBeKictnVJU6sItxwB9Wcrf7BeWqK9FC2Kyv0Vw1u1StZq3alNwUBvG
 JI8MDoNrXMJZkaUXF30fhKK4TUSdwgRkOxXUGYeqvlHPdTktF2WgWx/02uPjgualISxE
 Clw9dk/6LhhKvF9X2T5BVg3iK4ipUwv1r/Mjv97kJwqfDQn6qecPXljCwfYD81S8GsSN
 akDCWtHxil3iw81xfZYVbZPNjP2CMoGBdThRKjUANwwhKgWx+X29hJ/E2xhd/6XWHR4j
 T8LoGlm+TU4vhVgh6EWSfxc6CcAjH+GWMERwxxuZu45HSzIwvaBXwJHkSxjFANNdR5bp
 AXCw==
X-Gm-Message-State: AOAM533xjRZsEOalGl3V5JX9hWcXlgtC3YWd7/5Xetw0c5L5jMl6HvVy
 9P9uTIO4kBUh4etE3sIkzrUh/w==
X-Google-Smtp-Source: ABdhPJwPLaEjEPKwC34UrAC2gsulKg3s4j7+J97bZTNNIKaoZ/lJu48wNw2Iwm4BkDrJnbbca6y71A==
X-Received: by 2002:a63:1f18:: with SMTP id f24mr3506723pgf.133.1611301030526; 
 Thu, 21 Jan 2021 23:37:10 -0800 (PST)
Received: from [10.8.0.116] ([196.245.9.36])
 by smtp.gmail.com with ESMTPSA id fh7sm7835085pjb.43.2021.01.21.23.37.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 21 Jan 2021 23:37:09 -0800 (PST)
Subject: Re: [PATCH 1/2] block: remove unnecessary argument from
 blk_execute_rq_nowait
To: Christoph Hellwig <hch@infradead.org>
References: <20210121142905.13089-1-guoqing.jiang@cloud.ionos.com>
 <20210121142905.13089-2-guoqing.jiang@cloud.ionos.com>
 <20210121170257.GA4120717@infradead.org>
From: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Message-ID: <b87591b9-e598-6436-d41f-80cc56640549@cloud.ionos.com>
Date: Fri, 22 Jan 2021 08:36:45 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210121170257.GA4120717@infradead.org>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210122_023714_332635_DCC7CA42 
X-CRM114-Status: GOOD (  14.53  )
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
Cc: axboe@kernel.dk, linux-nfs@vger.kernel.org, linux-scsi@vger.kernel.org,
 linux-mmc@vger.kernel.org, linux-nvme@lists.infradead.org,
 virtualization@lists.linux-foundation.org, linux-block@vger.kernel.org,
 linux-ide@vger.kernel.org, target-devel@vger.kernel.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org



On 1/21/21 18:02, Christoph Hellwig wrote:
> On Thu, Jan 21, 2021 at 03:29:04PM +0100, Guoqing Jiang wrote:
>> The 'q' is not used since commit a1ce35fa4985 ("block: remove dead
>> elevator code"), also update the comment of the function.
> 
> And more importantly it never really was needed to start with given
> that we can triviall derive it from struct request.

Thanks Christoph, will add the above to header and send new version.

Guoqing

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
