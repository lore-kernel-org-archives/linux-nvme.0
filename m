Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5E3BCC6B1A
	for <linux-nvme@archiver.kernel.org>; Tue, 13 Oct 2026 20:09:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=v0gpLt7+oS9KQUHShMJeHfOIQi0PPRoxYfM2szDl9BQ=; b=hKKxqFKIFHteyWO0FTs6XmC4CN
	E3VGC2mJRnlGnP7/n5TGZS5Gr9gA+CZZE3Wql/eKHyfGiYWIGN/Slf+RaLUMWcczXy1CVpfNERZwn
	ca1hCoBhJKimKwmBE4qI9T+Jvh6cpfidddb8CwzVkwCw6nnjCraaLW6quUfTDsCEIg4W99HtyQdRY
	K2q8dIxqZlEpW4EVzohAivus9cW9dvH8FO0h7AGFjoix+TCK+vNc20j0YDVxIrf5Qak2DpWGNvzin
	ORDSjCiie88qIMJL3nZyqQq+5RDb8o13S8TtsETLbxsJ8gw5TJzW/1BupppIqbP09Rrws+jSBQSb+
	AEeSxmoA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xGioQ-0000000Dyzn-2PFh;
	Tue, 13 Oct 2026 20:09:26 +0000
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xGioN-0000000DyzE-37AK
	for linux-nvme@lists.infradead.org;
	Tue, 13 Oct 2026 20:09:25 +0000
Received: by mail-wr1-x431.google.com with SMTP id ffacd0b85a97d-487049569b6so2371687f8f.1
        for <linux-nvme@lists.infradead.org>; Tue, 13 Oct 2026 13:09:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791922161; x=1792526961; darn=lists.infradead.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=v0gpLt7+oS9KQUHShMJeHfOIQi0PPRoxYfM2szDl9BQ=;
        b=q8Dv+U0/g9y01La7rAEA5Rt5DELGUwWcu/pkLxYdUu4LBLuQQytmHeNP4njJ+bIswi
         ApOpyyMMtrUCjJD6tTv5t/Wu9zdlHatcsyq0JC4vQe1MRn28MZJ/ok9KhdZAMD9wDnqG
         Y7PkC4TIC1cCT9goSrBMke4ksoR0ifJz0fGLSDmBV3ctYccS1Xe4/wpvm/fIoaY0aH7E
         Ab4nVQ+qyKxttFezAxHMEPFVO1T4auc1mgs+TvqFFDXti2JqomLDIHT/ZREs68xw6+K1
         BEp1tHQye+WrOtyc7PBPVxXPIztHP0Nb+ifo2Ri9ajirUJMo/28UufMCerSNnm+CzDZX
         aFYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791922161; x=1792526961;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=v0gpLt7+oS9KQUHShMJeHfOIQi0PPRoxYfM2szDl9BQ=;
        b=HOQw6DHNoCRoaOAmtY50vJTlbQhmZWDL6fG26AR0w/j/Pate6AOL81LOVp0tbd31Vs
         nFv3+8tb7I+yw8E1j6QxQZUp/BkTIozS1cWzBCpUql2xxkhxgIFM5FWEYhVv6Fgw2REm
         ORgqMmWCN+hHSg6vgmnqLXxTzuPzum3afQ2SKjRRqyYSPNmE8h9cJVq8xVB6vC5bUHOv
         AXGwnQz1wSV33sNVNhx0VeQ/2/wQzc/jlNaAUJGkArklXmS5sa0xtRXtMX0YXWHB8uT1
         NMCwJPptr5xFUPQvouMPvh7LyIvqTTHRjtSQZgxkZW2rA0VYbM6uVAAolMQ/molPTDO/
         dVzw==
X-Forwarded-Encrypted: i=1; AKwUvBxqpoWyQn0E+KXUFv3343byzb66VEWbdSqookj4tHypA4mwC0HyUxXZAiqfRT8OCNARAulUbYjh6VEe@lists.infradead.org
X-Gm-Message-State: AFq9FYI2fRA6rubPo0rk8zSDYwrwNaInhGuqqTFHLVh8+dMTufEtYrfo
	x40wXkHKK91yDZosOVabAo5b9EHTPcrFtwAkugtYoHHSuW+m66H7l1YG
X-Gm-Gg: AYBFou0+A90MoWmkA0yB4uKkfPAmtbjNIje5woLBKVqtxL0oY2w6X1QmR3pCDh0yE8N
	J96qTLT2ZdD6BHTzVhtgQIA2Cd1IXq3jpFcZgLKfi05w72B84U1RtXnE3uxK66f/Dhpo+HcCxV7
	UBjpToyB8NdIHm1RQpRR2AU9Vx7OXRw+Ww+NKB3cjEjZmQxGYX7SdrbHGLY9ulVWd76An2A6n0p
	p0dDIC9fWUqc8AtEjaCU68pV50+38jpf9KWjs3rm3ggRdTguoXvmyKvPbi28hne5nDh/c3soFNz
	718WZEkEhi4oaoaYhYA6NiJ6dyLfYcCVNdR40B/DKvW7pdGeOK2sLoypQ+hTAYnHo+uyu5uYkIf
	FtpFXPRxOC2e7zMdcWgrs+QJDYvrMtLrGYPddCHEmHi4kYEZR1xKk+pa6s3vBwHKrh22senCxIE
	tguiqjEBrk6OuZURKhdU+YBh1Wm3E1J4k8FgqVoVQiY3xbPZZRi6coxUROVtsT4ERLFqAEakrgf
	v+jvVKRuAmXlD3T8R+bsSxQ462tQ9jrWvepKSFfx24uYJLd+u23iXZNznt66wBqgvlmu17FZuu/
	fbHrO/EjkXWP2kDDYtP+vCerjydiXbdaqtjkgN9Lr6g14yzE
X-Received: by 2002:a05:6000:310c:b0:487:8b9:526a with SMTP id ffacd0b85a97d-48dbacdaa60mr25864079f8f.36.1791922161609;
        Tue, 13 Oct 2026 13:09:21 -0700 (PDT)
Received: from ?IPV6:2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c? ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48de0ab5af7sm7243430f8f.31.2026.10.13.13.09.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Oct 2026 13:09:20 -0700 (PDT)
Message-ID: <293d49fb-6488-46da-bd3c-6f8600dd123d@gmail.com>
Date: Tue, 13 Oct 2026 21:09:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 00/13] Add dmabuf read/write via io_uring
To: Matthew Brost <matthew.brost@intel.com>, Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
 linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org,
 io-uring@vger.kernel.org, Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 Andrew Morton <akpm@linux-foundation.org>,
 Nitesh Shetty <nj.shetty@samsung.com>, Kanchan Joshi <joshi.k@samsung.com>,
 Anuj Gupta <anuj20.g@samsung.com>, Tushar Gohad <tushar.gohad@intel.com>,
 William Power <william.power@intel.com>, Alasdair Kergon <agk@redhat.com>,
 Mike Snitzer <snitzer@kernel.org>, Mikulas Patocka <mpatocka@redhat.com>,
 Benjamin Marzinski <bmarzins@redhat.com>, dm-devel@lists.linux.dev
References: <cover.1791336930.git.asml.silence@gmail.com>
 <d00e43fa-8f5b-4a8b-8b83-421d637ba519@kernel.dk>
 <20261013141046.GA12680@lst.de> <as6BMYAsWehHddlT@gsse-cloud1.jf.intel.com>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <as6BMYAsWehHddlT@gsse-cloud1.jf.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261013_130923_804353_A135ACEB 
X-CRM114-Status: GOOD (  20.53  )
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

On 10/13/26 20:06, Matthew Brost wrote:
> On Tue, Oct 13, 2026 at 04:10:47PM +0200, Christoph Hellwig wrote:
>> On Mon, Oct 12, 2026 at 02:21:41PM -0600, Jens Axboe wrote:
>>> I've queued this series up for some testing, in a separate branch. JFYI.
>>
>> More testing it obviously good.  I've been waiting for addressing
>> of the Sashiko comments on the nvme patches before doing more ACKs,
>> and while I can't really judge the code those in the dma-buf code
>> also look somewhat serious.  So it would be useful to get them addressed
>> and the series reposted.  Same for folding in the PI vs dmabuf fix
>> from Anuj, although making the combination work would of course be
>> even better.
>>
> 
> Oops, I forgot to look at Sashiko's feedback when I acked the dma-buf
> patch. I think the two cleanup issues are valid,

I stopped answering to sashiko as it repeats the same from version
to version when false positive. Those two are warning paths, which
should never happen, I'd rather leak than crash on double free or
so.

  but the reclaim-related
> ones are not. 

Thanks for confirming, you already elaborated on one of them in
previous revision, the new one looked to me as the same class of
issue as well.

I'm not sure why Sashiko is confused here.
> 
> I wonder if there are some shrinkers in the tree that incorrectly take
> dma-resv locks in a blocking manner. They should only use trylocks in
> shrinkers and direct reclaim paths.
-- 
Pavel Begunkov


