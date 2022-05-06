Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 682A6C433EF
	for <linux-nvme@archiver.kernel.org>; Fri,  6 May 2022 14:58:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Djq48YgZQsCdnDlnxXNGuTfAQr4XHcZ0oir+uN0p3tU=; b=nsdblTyKsyrk2tQ4R22UF92DWr
	zpLIE81YmvCFugLat2+H2W2j4k/uiF0Ilumvo0MqTU4eSo21nN5GSLr8HrvgjTaxbQqDo9azlAxWA
	mYk9pnyEiS0ZmwbPQcwpXov3q/pdQvzpNMdww6B3PKAvpXiJlnajDHctZz24n8bRaIdUwSeLAKllv
	RLC83uyxS+N/6rBnlBXfzUtMyYBuBlQ2qhu+Zts+k9oGtgtiWI5GC8eDpaYN5wbceQ8JuzNmVNfe9
	HZxf2mvaWkeQSDOcyKMpudXYcwK2zOgWoZlZ7kry4ez+XZHZia7JHGQserrRJQf3Ig663ASi/Zcf5
	7SFhkb6g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nmzP6-003v4f-2g; Fri, 06 May 2022 14:58:00 +0000
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nmzP2-003v2s-T2
 for linux-nvme@lists.infradead.org; Fri, 06 May 2022 14:57:59 +0000
Received: by mail-pl1-x62b.google.com with SMTP id c9so6977756plh.2
 for <linux-nvme@lists.infradead.org>; Fri, 06 May 2022 07:57:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel-dk.20210112.gappssmtp.com; s=20210112;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :cc:references:from:in-reply-to:content-transfer-encoding;
 bh=Djq48YgZQsCdnDlnxXNGuTfAQr4XHcZ0oir+uN0p3tU=;
 b=NslQb0mhJEYJPi+avsFd5SUo8tRP/ZVAMPHogekir8T1PauHtWhRZYgXXat0WBDd+Q
 e9Wa7yzoQO41PpNNoaiXG2rlqCDUTVVDzF5SuG4LQOneE7wVrpv6MOAKLInKWi9BJrqj
 tYon4md/oaFzZo4G7dfug/NKl9BHVOsLFZx4dIkFUZV0oR9T295bZ2g0OV82gH9g3Kw+
 71G5/+y+txf3cyjAhIUu5ujX60so7dgKq1FHYhQ6sKV1x27lHr/Yo9wMFgFf3gXPxFkA
 VXzX/WSS6EWRRmVuqcYLfSZ6L/YLfDqFJ5UViYfbjV2safW3sM/Qwdiqc0hDg5ixPHew
 cW2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=Djq48YgZQsCdnDlnxXNGuTfAQr4XHcZ0oir+uN0p3tU=;
 b=7A13OX/M+MEGKCWV8NDPa+AoFt10EWhLgnzAScjmSDLRWJt7OQUxMvZXdRdc7Hux/x
 8vjlg3aIDLb8uDwBJkdB5JUSsDcVmnObpPa1mTzm317EMd2yvL1L1C8Q9ODJ/wrpOTVI
 +E3xkuxivM4wW5X4YLBJdu15Gq73n5nV87XeeD5QhM0Q5OBFnat1W+3Ysn73LVwrCfsU
 IuEWQlOlNit+9nyh0ygEjFrEd62SJcsDIc7xhKr8KB6SUkqZm6/S3b2SRllvYxZB6D7S
 7bWfx4XcOPe/cllBsXCSFvHBjD5gFZVawupijaeTtQ+fCpSb5HslutvmUvWJtNcy/DOE
 K9GQ==
X-Gm-Message-State: AOAM531gbZP0yIOHCKz0XzVj01g+sR2PKSg3dhMNIIQ0yDrS+e8ISPtZ
 47ILfXrVJVXgZOEnr41VGiIS9Q==
X-Google-Smtp-Source: ABdhPJyeV9mn1yHYwfhn40dNQD/19QxNzIBhKfPAq7azOse9ud8rzl2hcDs6flBtwAGIJrXjHpbbFg==
X-Received: by 2002:a17:90a:730b:b0:1d9:7fc0:47c5 with SMTP id
 m11-20020a17090a730b00b001d97fc047c5mr4588862pjk.60.1651849076069; 
 Fri, 06 May 2022 07:57:56 -0700 (PDT)
Received: from [192.168.4.166] (cpe-72-132-29-68.dc.res.rr.com. [72.132.29.68])
 by smtp.gmail.com with ESMTPSA id
 q9-20020a170902bd8900b0015e8d4eb226sm1842446pls.112.2022.05.06.07.57.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 06 May 2022 07:57:55 -0700 (PDT)
Message-ID: <45b5f76b-b186-e0b9-7b24-e048f73942d5@kernel.dk>
Date: Fri, 6 May 2022 08:57:53 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v4 4/5] nvme: wire-up uring-cmd support for io-passthru on
 char-device.
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>
Cc: Kanchan Joshi <joshi.k@samsung.com>, io-uring@vger.kernel.org,
 linux-nvme@lists.infradead.org, asml.silence@gmail.com, ming.lei@redhat.com,
 mcgrof@kernel.org, shr@fb.com, joshiiitr@gmail.com, anuj20.g@samsung.com,
 gost.dev@samsung.com
References: <20220505060616.803816-1-joshi.k@samsung.com>
 <CGME20220505061150epcas5p2b60880c541a4b2f144c348834c7cbf0b@epcas5p2.samsung.com>
 <20220505060616.803816-5-joshi.k@samsung.com>
 <f24d9e5e-34af-9035-ffbc-0a770db0cb20@kernel.dk>
 <20220505134256.GA13109@lst.de>
 <f45c89db-0fed-2c88-e314-71dbda74b4a7@kernel.dk>
 <8ae2c507-ffcc-b693-336d-2d9f907edb76@kernel.dk>
 <20220506082844.GA30405@lst.de>
 <6b0811df-e2a4-22fc-7615-44e5615ce6a4@kernel.dk>
 <20220506145058.GA24077@lst.de>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20220506145058.GA24077@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220506_075756_985477_C7AD927D 
X-CRM114-Status: GOOD (  19.29  )
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

On 5/6/22 8:50 AM, Christoph Hellwig wrote:
> On Fri, May 06, 2022 at 07:37:55AM -0600, Jens Axboe wrote:
>> Folded most of it, but I left your two meta data related patches as
>> separate as I they really should be separate. However, they need a
>> proper commit message and signed-off-by from you. It's these two:
>>
>> https://git.kernel.dk/cgit/linux-block/commit/?h=for-5.19/io_uring-passthrough&id=b855a4458068722235bdf69688448820c8ddae8e
> 
> This one should be folded into "nvme: refactor nvme_submit_user_cmd()",
> which is the patch just before it that adds nvme_meta_from_bio.
> 
>> https://git.kernel.dk/cgit/linux-block/commit/?h=for-5.19/io_uring-passthrough&id=2be698bdd668daeb1aad2ecd516484a62e948547
> 
> Just add this:
> 
> "Add a small helper to act as the counterpart to nvme_add_user_metadata."
> 
> with my signoff:
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Both done, thanks.

>> I did not do your async_size changes, I think you're jetlagged eyes
>> missed that this isn't a sizeof thing on a flexible array, it's just the
>> offset of it. Hence for non-sqe128, the the async size is io_uring_sqe -
>> offsetof where pdu starts, and so forth.
> 
> Hmm, this still seems a bit odd to me.  So without sqe128 you don't even
> get the cmd data that would fit into the 64-bit SQE?

You do. Without sqe128, you get sizeof(sqe) - offsetof(cmd) == 16 bytes.
With, you get 16 + 64, 80.

-- 
Jens Axboe


