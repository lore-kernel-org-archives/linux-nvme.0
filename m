Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2579C55ABF
	for <linux-nvme@archiver.kernel.org>; Tue,  4 Aug 2026 17:16:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=64eSuQSg7peuhPy9EAyTkvD08lRNBOCEScrOfZTKXsQ=; b=qQ9rYr+ABc+3QFk+npsQPd4d+C
	hmFsd5ZkyScxXWpq54kw8zE1KWddIfpqC4KFR7wNQSbnPbIDqcV28L1uIhuxtiWtvuvLKLqtnXZ1z
	D8USKmHjEXW8oO+0aXxy4cyRIhDRLNK9VEJX5tBxNu43/lNdwizTbSUrxPAmfbCdBiliiTddb54jy
	t4Yi60Wm3WG9J4IKvxEUdqk02ipDXl2HqW3LVZVC86Hv0Iy2vL/iS/a9xwwGvEfTllqEXHaa6vwbV
	u7lIPAvSZRDZxEuoOeaVpo/XynZ64WShCROVX3OtenmC621vq29n+w0XQE8kO57XFww77DPKuDA0X
	3dMXkkhw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wrIkW-00000002SsZ-0iu1;
	Tue, 04 Aug 2026 17:16:20 +0000
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wrAgk-00000001MXu-0Mxd
	for linux-nvme@lists.infradead.org;
	Tue, 04 Aug 2026 08:39:55 +0000
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-2caf228a910so31910405ad.2
        for <linux-nvme@lists.infradead.org>; Tue, 04 Aug 2026 01:39:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785832793; x=1786437593; darn=lists.infradead.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=64eSuQSg7peuhPy9EAyTkvD08lRNBOCEScrOfZTKXsQ=;
        b=srDxmfqb4A7xFRs49UbK5ZzJ1h/enA8qab/rdWKFolRr5iziK65I4PXwltt9bYJ16t
         h/2eVXbG7B6Ku3bCP23WEz8xOL9jPVVpXTo2r0rfieJEdG6G1KgQk1mS4Yga0mHfQm7j
         KmPIQaGHLDfJVAoRHPm0sc/m0uyePyoOAscyw0SBkfL2Goh7Tw41leVj0UKZDHIK8HpC
         IYdL8xIC4/CC2oz7EZBI2dOR2YAVD+kumKWAjpMcgiVyPggq+ugo4NnRIIyWwMgk4Q8D
         Ek8hYHhsEgANfHpnBE7txA6R5fl6h9coSb32qrTL3bvT0ZYjwW4XUVlSIaxMx/pjwvNd
         imUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785832793; x=1786437593;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=64eSuQSg7peuhPy9EAyTkvD08lRNBOCEScrOfZTKXsQ=;
        b=cZjn28cuST8Km/sCVTANXOkxtuj8wy7Y5Olda11mMTHIOFE/QXyeyk2zY3+mHpbm0u
         +G9fl6FXGjpKv9q13Zfe5gr7fNNE5HATNvQgdkuZPMJjn6ZMNxsLa0NhaRpTnA6oq5UX
         8+DSivGbXvtNJ85ktfa0ZqfllOQc9MTv+dDfncG2PMnuF6MGLnhBotYa2JDsiiLT9M6Y
         IUUY55l12jBHeavbO1OkpWZqjSXWxuZDFXz8vTV6BJJeQIPLGGxQLmBEdBPebx7kFrI6
         mwv4VgGoJR9qo0sRH3UwNTBd3jSPJE2YeJTlR0fjxvpIGwuqj/6MpGvYqvfr/eSZxBXz
         3z7A==
X-Forwarded-Encrypted: i=1; AHgh+Rr8rZVFF6lUZRZ0yZOAtZtjB2bXjaacZ2Wul0xreJVy5JDo9CMoTXtv6r3f4CClysJUd2HULiM7k6rq@lists.infradead.org
X-Gm-Message-State: AOJu0Yz/tTaJbd6KK89E/+MT+mAjQXxTOmOTbanlLWJMQU6v5MEgexWn
	ORGZjUEX0rrLqkRnuGRLp44Lu3o2wqo9cQuPLrjxOpSsPsyUTEnpClnf
X-Gm-Gg: AR+sD128NEJF4B0pF+ZHn1XSEZXSGPEhU8VuzOKwqGNV6qVVQ894GlbO6hDaBAHyEs+
	dl0lDknKKh0ANka3pmC4KHfEAXa6NPA8Q6vZGSWLONeBF+QMrW28l0f6qpHAixVy6Gt42Id1HWu
	HhVCxjPh+tpfo54gXmqSlCNn5DZOIV3L55hvxoJyPCbxO0xmZQFAV1dS53HMizo7mL9apfMAI0S
	npYYoXrVVuWOj2fAQkfwwKOPG8FHtuDv33hltVId/VtWLg2V1m9ZerV+rF6KmV+gFcE/gR10jWV
	DTq+vzaplIwjxgf1GzyxGTj0ySEU/jQB82qOUg4K8i2h5AsJjtWNgR12BW4XYA7HqmJipaxseL7
	tdIqz4B/5/S/Pcno8OhGNtsRjMCn5zQAaxQciX6fZrESJl5BMefl9hHO+zALdWBY9TSLl/ZEb3X
	+qzmUhL/GevZp3D125GGPMG4EOSLGhd/oYyUpokQy8I/8pbOexTq1cDcEUPgkyiHjrmMvwTSENY
	FHAkKLeiORxgzVMt4lmJZ01gmqMN7BoR6FIz1wXVhzgUAO4UyAcMvpOhIs2hJwcTc8Jk+y+sScY
	Qp1mXPSn6KXxibcdIf9f
X-Received: by 2002:a17:902:da81:b0:2c9:e69f:8b0f with SMTP id d9443c01a7336-2d0521dd6e5mr137791555ad.17.1785832792742;
        Tue, 04 Aug 2026 01:39:52 -0700 (PDT)
Received: from ?IPV6:2620:10d:c096:325:77fd:1068:74c8:af87? ([2620:10d:c092:600::1:541b])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d0a9f93703sm3064405ad.7.2026.08.04.01.39.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Aug 2026 01:39:51 -0700 (PDT)
Message-ID: <214cf82d-742a-4753-bc86-c249366b54ed@gmail.com>
Date: Tue, 4 Aug 2026 09:39:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 02/16] iov_iter: add iterator type for dmabuf maps
To: Anuj gupta <anuj1072538@gmail.com>
Cc: Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org,
 io-uring@vger.kernel.org, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Nitesh Shetty <nj.shetty@samsung.com>, Kanchan Joshi <joshi.k@samsung.com>,
 Anuj Gupta <anuj20.g@samsung.com>, Tushar Gohad <tushar.gohad@intel.com>,
 William Power <william.power@intel.com>, Phil Cayton
 <phil.cayton@intel.com>, Jason Gunthorpe <jgg@nvidia.com>,
 Damien Le Moal <dlemoal@kernel.org>, Alasdair Kergon <agk@redhat.com>,
 Mike Snitzer <snitzer@kernel.org>, Mikulas Patocka <mpatocka@redhat.com>,
 Benjamin Marzinski <bmarzins@redhat.com>,
 Vishal Verma <vishal.l.verma@intel.com>, David Sterba <dsterba@suse.com>,
 Ilya Dryomov <idryomov@gmail.com>, dm-devel@lists.linux.dev,
 nvdimm@lists.linux.dev, linux-btrfs@vger.kernel.org,
 ceph-devel@vger.kernel.org
References: <cover.1785596451.git.asml.silence@gmail.com>
 <c1ab6c0db3853b339a89aee0b1a9c5ac0c48b79e.1785596451.git.asml.silence@gmail.com>
 <CACzX3AvwBF32_ODomei3XHSZ=KtRaWLN-_Tfkwv7sV3Ssc3wmw@mail.gmail.com>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <CACzX3AvwBF32_ODomei3XHSZ=KtRaWLN-_Tfkwv7sV3Ssc3wmw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260804_013954_127103_CC8C57AF 
X-CRM114-Status: GOOD (  14.61  )
X-Mailman-Approved-At: Tue, 04 Aug 2026 10:16:17 -0700
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

On 8/3/26 14:20, Anuj gupta wrote:
> On Sat, Aug 1, 2026 at 9:19 PM Pavel Begunkov <asml.silence@gmail.com> wrote:
>> @@ -841,7 +857,7 @@ static unsigned long iov_iter_alignment_bvec(const struct iov_iter *i)
>>
>>   unsigned long iov_iter_alignment(const struct iov_iter *i)
>>   {
>> -       if (likely(iter_is_ubuf(i))) {
>> +       if (likely(iter_is_ubuf(i)) || iov_iter_is_dmabuf_map(i)) {
>>                  size_t size = i->count;
>>                  if (size)
>>                          return ((unsigned long)i->ubuf + i->iov_offset) | size;
> 
> dmabuf_map shares the same union slot as ubuf, so this reads the map
> pointer as a user address. gap_alignment() below already returns 0
> correctly for dmabuf - this should too. Checked the rest of this patch
> (advance/revert/restore) - none of them dereference the union pointer
> for dmabuf, so it's isolated to this one spot. Doesn't affect the
> current series, nothing reaches this with a dmabuf iter yet.

Ah yes, that's nonsense, it should've checked iov_offset instead. Thanks

-- 
Pavel Begunkov


