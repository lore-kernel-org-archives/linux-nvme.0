Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32B73C433EF
	for <linux-nvme@archiver.kernel.org>; Tue, 10 May 2022 12:29:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=0mqM+Vn2EmZKarvnvapcYOpxk7HIDCq9WOkrcf2C2VI=; b=KqZhWSzMbiyFWmNApuZ+Ue8+Vc
	95adh3RjpA+D34KIqv+lYpCKj3F+fC+qWtUOd3Wy2iw+hIz7S4766Qe7wYW5Mey08W0c9rylNjFuP
	GbsT8/Y/st8aBWhu/Xsg9zas3NYbvQlKKmYlvVP9eSJJQ8/uNT5m5VMRxlu8Lk9E+RvWuTcJqBeNs
	cQEW3NidIHJUTC6zbA32U5It01krjcOzstju0oVYhKfVNCELBYji4xUwv3nmF26Eqv7eQsXj35XbB
	WWLX7KYyK4+DGGw0VhBxnf0OR3hHGcXZNQZfOmDhIfV3iPnB0PwFhOey+Dy1VPCPpNAl9tql351gW
	5cyIYLDg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1noOzJ-001sUv-Vb; Tue, 10 May 2022 12:29:13 +0000
Received: from mail-pj1-x102a.google.com ([2607:f8b0:4864:20::102a])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1noOzH-001sTJ-3q
 for linux-nvme@lists.infradead.org; Tue, 10 May 2022 12:29:12 +0000
Received: by mail-pj1-x102a.google.com with SMTP id
 w17-20020a17090a529100b001db302efed6so2002844pjh.4
 for <linux-nvme@lists.infradead.org>; Tue, 10 May 2022 05:29:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel-dk.20210112.gappssmtp.com; s=20210112;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :cc:references:from:in-reply-to:content-transfer-encoding;
 bh=0mqM+Vn2EmZKarvnvapcYOpxk7HIDCq9WOkrcf2C2VI=;
 b=e23eahSKZf3cSlA8ujBRQ4oE2ZBCvr/24SddTvZCHb5yGX1IrFUzPZ+EkRdGPnVNOR
 wOZUgihNQBnF7jYq7lF9FvyMp15beHuOPSezIKJqgxOCHvq3xq9wpoM1NKkhIfQ646QQ
 6uBmVJr41Hut6E8YT1Ffehm0mxOGk6yURFDq5dlEXrW9eKuVz3sEKwpNsPb7U0REZ0yH
 gPycQU7kTl5p47VnPR0hxmrO0bjF+960fq2aX+kEEdbUNpIHoBKlvo1y2llp6GVYN8Cl
 JueiE+Bj6efMnMeirHtn2gQR82EQEYCWs5u81XX6CT5z3tdBmN3G4xszkWsGas7bbgu3
 mVyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=0mqM+Vn2EmZKarvnvapcYOpxk7HIDCq9WOkrcf2C2VI=;
 b=jaUvfe6Q4nbOOat2oGQ3NaFGTCsO67V7wIU7UTu2H0J5kDpjTBToj0Kpw22wxpBy8j
 hyZPDeMi11ibL+cvmcMhpo4pTcyzZ5k6cvjM9ihxTutrZYxf5u6ussE9YSnsL+RP6bV9
 c4e+2svBvtwGMpCvtJmT/t/E8KlTceFEWDiXJNyAHXYTY7dtPdKEjyzYdRUN1U4Aa9yy
 vKm6ZyRoWihNY4isdPuMLG+hJkacpxmoDL342Dik9bjEZ1g1VZ/NH9fnqeT/ZmFt3+oZ
 RBiejZhG9BSKeYOg5qQ4YGyt4goRC0WkxEq6M6aA3waCRYowtYtHfd19H/FgYrycqm6l
 Dbiw==
X-Gm-Message-State: AOAM532fsQy3IIRCgrwfkChjIcq0pMRLo6E2yv7MLIo0i7yiyHCfMXrZ
 CO/s/RxUwwsciXAuV9qS5BUw2Q==
X-Google-Smtp-Source: ABdhPJy36BsTH0DaztTJ6km0Y+7DkYSKAiup8qM4iZk1mIQOhEXup8q5DWS5wRyvPw4aWFkJSL+IOw==
X-Received: by 2002:a17:903:20f:b0:158:d86a:f473 with SMTP id
 r15-20020a170903020f00b00158d86af473mr20541356plh.92.1652185748582; 
 Tue, 10 May 2022 05:29:08 -0700 (PDT)
Received: from [192.168.1.100] ([198.8.77.157])
 by smtp.gmail.com with ESMTPSA id
 a21-20020a056a001d1500b0050dc7628147sm10281247pfx.33.2022.05.10.05.29.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 10 May 2022 05:29:08 -0700 (PDT)
Message-ID: <2a09399d-480e-8b03-8303-57287f7b5c64@kernel.dk>
Date: Tue, 10 May 2022 06:29:06 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v4 0/5] io_uring passthrough for nvme
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>
Cc: Kanchan Joshi <joshi.k@samsung.com>, io-uring@vger.kernel.org,
 linux-nvme@lists.infradead.org, asml.silence@gmail.com, ming.lei@redhat.com,
 mcgrof@kernel.org, shr@fb.com, joshiiitr@gmail.com, anuj20.g@samsung.com,
 gost.dev@samsung.com
References: <CGME20220505061142epcas5p2c943572766bfd5088138fe0f7873c96c@epcas5p2.samsung.com>
 <20220505060616.803816-1-joshi.k@samsung.com>
 <d99a828b-94ed-97a0-8430-cfb49dd56b74@kernel.dk>
 <20220510072011.GA11929@lst.de>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20220510072011.GA11929@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220510_052911_226066_D9061A6E 
X-CRM114-Status: GOOD (  16.70  )
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

On 5/10/22 1:20 AM, Christoph Hellwig wrote:
> On Thu, May 05, 2022 at 12:20:37PM -0600, Jens Axboe wrote:
>> On 5/5/22 12:06 AM, Kanchan Joshi wrote:
>>> This iteration is against io_uring-big-sqe brach (linux-block).
>>> On top of a739b2354 ("io_uring: enable CQE32").
>>>
>>> fio testing branch:
>>> https://github.com/joshkan/fio/tree/big-cqe-pt.v4
>>
>> I folded in the suggested changes, the branch is here:
>>
>> https://git.kernel.dk/cgit/linux-block/log/?h=for-5.19/io_uring-passthrough
>>
>> I'll try and run the fio test branch, but please take a look and see what
>> you think.
> 
> I think what is in the branch now looks pretty good.  Can either of you
> two send it out to the lists for a final review pass?

Kanchan, do you want to do this?

-- 
Jens Axboe


