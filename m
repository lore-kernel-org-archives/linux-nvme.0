Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81C74CA5FFC
	for <linux-nvme@archiver.kernel.org>; Wed,  7 Oct 2026 01:40:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=HDM/IhuAZ+mZ2yb1biv87C3WVL00TVKLh/5oVRCg27Q=; b=ycNu2LKVp6CUvovXhuorm5+Tt/
	Xv/B5NHVHSYc1DfYOcBpKbcPWOvVKoNo4Aprq3ItQrsOqg6DWvYQRO4UZrG6NbHUCqv9trIV8zx9z
	rWbvbtx0rWwTiAM+4KpIhV0yk9xHkHEcn51lk/2+f2K51UNNf+jlETAFbOySRcjSpwX2r0vxk7dID
	kMo5YeP0pb6ASn12SqrXMwq83Pq6aqASRAbzyxiKIcBfJ9lAUjE/uNIK65NEIG6AUcqF0MtpVXNgv
	bTlxMmgIQK5p05sxraobOwUNXMliHFFSlvZUk1QBaeSRoqSC7RkDvsy8pmmIYskz5/Ft/RTfwUFLy
	9JzPtaZQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xEGdv-00000001c3t-33hi;
	Wed, 07 Oct 2026 01:40:27 +0000
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xEGds-00000001c3R-3Wut
	for linux-nvme@lists.infradead.org;
	Wed, 07 Oct 2026 01:40:25 +0000
Received: by mail-wr1-x429.google.com with SMTP id ffacd0b85a97d-48b9d8055dfso2900173f8f.3
        for <linux-nvme@lists.infradead.org>; Tue, 06 Oct 2026 18:40:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791337223; x=1791942023; darn=lists.infradead.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HDM/IhuAZ+mZ2yb1biv87C3WVL00TVKLh/5oVRCg27Q=;
        b=BD3gaPXNQAyMfuwuIkgHsVRh3d3nDxS4TGkVDAqQDBk9NxQIsjCbW7c7I5TCF2Q2qT
         aAjmGyc1ICaIdeyGk+TW1wm9ySQd8ia038m0F82AaJ90BpD8jtaS/T7wrwMVPsQlavUl
         JrtsPU8eifnQpkp/FWZ6O8iyhtYTmjLV/UXibpJIn2rRypP+mZNKaX+0D6oJojogN9p5
         2TIT4eP2y+AnNInUli12ic+LEtqv/e3EZ0zbucUYK/ntAJAmqAAzykYLP5iZZtXS04ni
         msGnOLp77CRM8Wn/S1BThehuFX0fhwPrIxxGdoDbhxx6aysmNbO8KdSzi+TaDnKz5Kjm
         roPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791337223; x=1791942023;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HDM/IhuAZ+mZ2yb1biv87C3WVL00TVKLh/5oVRCg27Q=;
        b=ZdnjKX64/n5gZax/AYu4t63BU2ubs3e9rT+C+XKRfqq5kGoSzBTTyRTj8kCz9AcE2f
         u4tI8LTUdfBxaFjjrOkUubmUwe5lQe+vlHqWmflpWQck6g0JTl05j+JzVVrwdjHJr0Am
         uR4gDbFajLGvmtdM/6Q+DkWBBfWI4X+PhhvhS/wWFrHx4TA0TzX7wuiukbsuVH4478jI
         /Nw8lKNyq+E4lMtKg4lOiCCEHPv5lwbxHxe6r/RqcuajoVQMhPVyp8WCrCr5HPuFw/Ns
         SIOhJgljptarFc+cfkinzVzx4NAwX2Ohd4aEFUWDBSfLWxB4VHfx3SXUoD6AlGQC67Pp
         BXWw==
X-Forwarded-Encrypted: i=1; AKwUvBxoYrvaTK/L/nbq8qXGLdxavuPMwzBPGVGMNcGd70yKUTy+fP2V/Xu2F+hfbPycr29gsq9aViNnig+i@lists.infradead.org
X-Gm-Message-State: AFq9FYIaSGiBhYs+Td531w54+3iteArV21YXGICY22Oz5pCsEfxG66FO
	r54o0WxKIywHuUMm+LH3AZxE3rxTl9ZAVebV2wtPIWxitiTJzVc9SH/A
X-Gm-Gg: AYBFou1snVED6TNks+kSe6RSlFDlv/9InImzP1yhTFIjV+9sQnm0qPQFucyShZF7dzo
	PFkiMJ+seQmA0mM+dNg4x1+sJ7Luay8W3OmetOmqb6MZkdRhLePRfnCuC8PLfuHubqRqAWmXYB3
	jyOitL9n9/EE0dmfThljFekcZPSwlco9K9rxpdomqDmBu9JWg3AThBMkvWADNQ78LbLqxKhbFYb
	P+19yDKccbXWPSGdZ71sHuXwAhGWRnBAEU8tShOOgKSCIRHPLKkla8oR8QFSXg8JhVRXHFJhTNj
	4cnvhzUzwCQYPm61YdQM6k+9+oFXAQxX0qXjfYJ2ZlZuy/LKoY62XcLi18AZga/Bxz0GzeKeMw6
	M0he92tzPmQvDi6nE+cxe9VrsdGKjR8Jlhe/SpMp4/siMBYk3BjfHcmXt3is9PNQ0sHEJ0U0WmA
	Nvyn3AN83PlNXGP671LpXPkTYV9UBQMJy83eJjXAlXwbrRLEgWtaJhj26gXEEAs+RsnR2/iewDy
	7Q1txsxuKog/b2aHuTXYMONySfKNRmeZDb3dyqzmXS14zPae79BKSzurH0JjWLacLuH7PirZ9oo
	xXS5y4U68T/05PAb7shSJNnbSOvH5xBrnFQeVvw5I5FJz6dV
X-Received: by 2002:a5d:4b10:0:b0:488:8546:d0b2 with SMTP id ffacd0b85a97d-48c7289605amr1226256f8f.51.1791337222906;
        Tue, 06 Oct 2026 18:40:22 -0700 (PDT)
Received: from ?IPV6:2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c? ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48c7202fa0bsm2238873f8f.3.2026.10.06.18.40.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Oct 2026 18:40:22 -0700 (PDT)
Message-ID: <38719270-2ee9-477b-aa31-b4f90bcba020@gmail.com>
Date: Wed, 7 Oct 2026 02:40:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 00/13] Add dmabuf read/write via io_uring
To: linux-block@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
 linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org,
 io-uring@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 Andrew Morton <akpm@linux-foundation.org>, Jens Axboe <axboe@kernel.dk>,
 Nitesh Shetty <nj.shetty@samsung.com>, Kanchan Joshi <joshi.k@samsung.com>,
 Anuj Gupta <anuj20.g@samsung.com>, Tushar Gohad <tushar.gohad@intel.com>,
 William Power <william.power@intel.com>,
 Matthew Brost <matthew.brost@intel.com>, Alasdair Kergon <agk@redhat.com>,
 Mike Snitzer <snitzer@kernel.org>, Mikulas Patocka <mpatocka@redhat.com>,
 Benjamin Marzinski <bmarzins@redhat.com>, dm-devel@lists.linux.dev
References: <cover.1791336002.git.asml.silence@gmail.com>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <cover.1791336002.git.asml.silence@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261006_184024_926519_9E0CE4EF 
X-CRM114-Status: GOOD (  13.51  )
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

On 10/7/26 02:31, Pavel Begunkov wrote:
> The patch set allows to register a dmabuf to an io_uring instance for
> a specified file and use it with io_uring read / write requests. The
> infrastructure is not tied to io_uring and there could be more users
> in the future. A similar idea was attempted some years ago by Keith [1],
> from where I borrowed a number of changes. Later it was brough back up
> to life by Tushar and Vishal.

Apologies for a messed up submission, please ignore. I'm going to
send v9.

-- 
Pavel Begunkov


