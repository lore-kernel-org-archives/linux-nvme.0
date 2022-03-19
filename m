Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEF46C433F5
	for <linux-nvme@archiver.kernel.org>; Sat, 19 Mar 2022 07:29:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=MtnQkQQa4FWyZNWbj9JSTFrxAsO52s5iMepRv7LRB74=; b=gcuBVBZUpbXm3FMolB2swkiZwm
	S5sbOpfTax7y5uBJEztQfMWDGOjV7V42rFC4YICFzgiXY8xt/GUeBa9WojZ2M+8TtjoHapsM9heh2
	5OwYN2SsdOxLlUFBG7pBVUTCFZ6XhtwDNpgWuF/pxRZ01XX4GfYST+tAG/YFD1RGPQSmF5N2ZIkBM
	z+IWxvfZymvuvkJKkjoQEkdnJssBgbb+pb/ziWb+CV91l8Rp5+h+BL0gs+cMjPWPLCxiFNszdv22Y
	Z/dQSa83WDtnsNjypxcBEIBXHMs8OtWsZC4w8md1Gxj7B/C/YKJQyBAPdgQIizkdID/kOwtrQ/EEd
	x2iGdnZA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nVTWo-003Nxl-OJ; Sat, 19 Mar 2022 07:29:34 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nVTWi-003Nwi-K8
 for linux-nvme@lists.infradead.org; Sat, 19 Mar 2022 07:29:30 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1647674966;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=MtnQkQQa4FWyZNWbj9JSTFrxAsO52s5iMepRv7LRB74=;
 b=FYp3Z0L4VHfIydqlH+9ftOMW875G+VwagRWj9rKy9UA9uLj+kYeWMoZJ9VuUJiC7T6i+Ze
 kEEiHaHs8KDD3N6MCXkGP+Bi4HnwxuZwiVz4K//nSFMbnpSjphR8uSc6YE0AFzOKqSPtUw
 X5llshnb8h4RbTSbnsGuFQSJIDSJR7A=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-511-O37mIFAWM3uv6jP5lw-v7g-1; Sat, 19 Mar 2022 03:29:23 -0400
X-MC-Unique: O37mIFAWM3uv6jP5lw-v7g-1
Received: by mail-pj1-f71.google.com with SMTP id
 t12-20020a17090a448c00b001b9cbac9c43so6119287pjg.2
 for <linux-nvme@lists.infradead.org>; Sat, 19 Mar 2022 00:29:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=MtnQkQQa4FWyZNWbj9JSTFrxAsO52s5iMepRv7LRB74=;
 b=Cdpu36qFsKVO8a1lLaMjvZNlNO2Dlezabw/NjTKWJlL9cB9cj7OyS5kAFsroSOyyhE
 +ZTmDnRLAUJ/bB5fClzpTUfmmo0iZ2uoCHz4247646acZmgLiS1okQB8y/c5KoTyYsDk
 +wD8bEtMdv18LyMv5jWukZ2v7CpX2/pkQ+G2UZ9gF4jl7/urMsB0yDqLn7GSec7yjwbe
 D2AXyAc2r30VO0HpZkTvEpqOk0tmWfcWQbmjaAWMggfO5aLcydLc4p1zvlcRIPoOGfGX
 r13vdyPafK0xj8QdVkkaSU1vxFrbVOaruE7BTP6tscXLHBxla69pBWrKNxv1yx2QCr6P
 7mXg==
X-Gm-Message-State: AOAM531Lhn6vtxcEqLRqUsA6w4Xkol8vbvX3Lh9sTKwpGQL5jvCzrW67
 FvOPZyecbGx8dA57UKeUr+LMoMNrv6+aEf+UxxjXP+CcmzElKJfetoJJRWFUwdK5RjV5ecfQKMw
 klTRU5YyucgUdi1IWDGv0r9X/QhZie/EU75tcUPJDROU=
X-Received: by 2002:a17:90b:33cc:b0:1c6:6012:5647 with SMTP id
 lk12-20020a17090b33cc00b001c660125647mr17714282pjb.165.1647674962736; 
 Sat, 19 Mar 2022 00:29:22 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwZBiajyKjPniL5vHn8R/XlXmGH8c65aXx12XtgM9iLtUtANOiWcGdnCRQ0iTevi4kj7fYK59f8qsckAchB6F8=
X-Received: by 2002:a17:90b:33cc:b0:1c6:6012:5647 with SMTP id
 lk12-20020a17090b33cc00b001c660125647mr17714271pjb.165.1647674962480; Sat, 19
 Mar 2022 00:29:22 -0700 (PDT)
MIME-Version: 1.0
References: <CAHj4cs8cT23z+h2i+g6o3OQqEhWnHS88JO4jNoQo0Nww-sdkYg@mail.gmail.com>
 <3292547e-2453-0320-c2e7-e17dbc20bbdd@nvidia.com>
 <CAHj4cs9QuANriWeLrhDvkahnNzHp-4WNFoxtWi2qGH9V0L3+Rw@mail.gmail.com>
 <fcad6dac-6d40-98d7-93e2-bfa307e8e101@nvidia.com>
 <CAHj4cs_WGP9q10d9GSzKQZi3uZCF+S8qW1sirWZWkkHuepgYgQ@mail.gmail.com>
 <2D31D2FB-BC4B-476A-9717-C02E84542DFA@oracle.com>
 <CAHj4cs-yt1+Lufqgwira-YbB6PHtJ=2JA_Vora_CfarzSzoFrA@mail.gmail.com>
 <4BB6D957-6C18-4E58-A622-0880007ECD9F@oracle.com>
 <CAHj4cs_ta5WR7j0qvHyr1tSCR-U7=svY5j8Hctd7YUMNcGXsaA@mail.gmail.com>
 <a2fabeb3-5f19-11b6-8c00-a479e3759182@grimberg.me>
 <bdb675e4-1de8-400b-9d43-9f0c18147dc4@nvidia.com>
 <CAHj4cs_C=pCz41hg1AnQcEZPBRK78WTUq8HE3n_28t56iN1FuA@mail.gmail.com>
 <fe9842f1-e5c7-7569-426e-9029662bb4f3@nvidia.com>
 <CAHj4cs8fNmj2Mn7Srs547ji51x7mQ8ZWKzFOuJaENe=vKpBJ-A@mail.gmail.com>
 <6347079f-ec3b-c2e5-bb3b-43b539d6d3f1@nvidia.com>
 <CAHj4cs_ir917u7Up5PBfwWpZtnVLey69pXXNjFNAjbqQ5vwU0w@mail.gmail.com>
 <6d8f4525-f663-18cc-8644-bfddd7d86bd0@grimberg.me>
In-Reply-To: <6d8f4525-f663-18cc-8644-bfddd7d86bd0@grimberg.me>
From: Yi Zhang <yi.zhang@redhat.com>
Date: Sat, 19 Mar 2022 15:29:10 +0800
Message-ID: <CAHj4cs_ff3TGnD2QJSzx3QJQKc1HkF=TJkh_MokqGK3n8NWyQQ@mail.gmail.com>
Subject: Re: [bug report] NVMe/IB: reset_controller need more than 1min
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Max Gurtovoy <mgurtovoy@nvidia.com>, Max Gurtovoy <maxg@mellanox.com>, 
 "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>, 
 RDMA mailing list <linux-rdma@vger.kernel.org>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=yizhan@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220319_002928_767866_519BB13B 
X-CRM114-Status: GOOD (  15.42  )
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

On Wed, Mar 16, 2022 at 11:16 PM Sagi Grimberg <sagi@grimberg.me> wrote:
>
>
> >> Hi Yi Zhang,
> >>
> >> thanks for testing the patches.
> >>
> >> Can you provide more info on the time it took with both kernels ?
> >
> > Hi Max
> > Sorry for the late response, here are the test results/dmesg on
> > debug/non-debug kernel with your patch:
> > debug kernel: timeout
> > # time nvme connect -t rdma -a 172.31.0.202 -s 4420 -n testnqn
> > real    0m16.956s
> > user    0m0.000s
> > sys     0m0.237s
> > # time nvme reset /dev/nvme0
> > real    1m33.623s
> > user    0m0.000s
> > sys     0m0.024s
> > # time nvme disconnect-all
> > real    1m26.640s
> > user    0m0.000s
> > sys     0m9.969s
> >
> > host dmesg:
> > https://pastebin.com/8T3Lqtkn
> > target dmesg:
> > https://pastebin.com/KpFP7xG2
> >
> > non-debug kernel: no timeout issue, but still 12s for reset, and 8s
> > for disconnect
> > host:
> > # time nvme connect -t rdma -a 172.31.0.202 -s 4420 -n testnqn
> >
> > real    0m4.579s
> > user    0m0.000s
> > sys     0m0.004s
> > # time nvme reset /dev/nvme0
> >
> > real    0m12.778s
> > user    0m0.000s
> > sys     0m0.006s
> > # time nvme reset /dev/nvme0
> >
> > real    0m12.793s
> > user    0m0.000s
> > sys     0m0.006s
> > # time nvme reset /dev/nvme0
> >
> > real    0m12.808s
> > user    0m0.000s
> > sys     0m0.006s
> > # time nvme disconnect-all
> >
> > real    0m8.348s
> > user    0m0.000s
> > sys     0m0.189s
>
> These are very long times for a non-debug kernel...
> Max, do you see the root cause for this?
>
> Yi, does this happen with rxe/siw as well?

Hi Sagi

rxe/siw will take less than 1s
with rdma_rxe
# time nvme reset /dev/nvme0
real 0m0.094s
user 0m0.000s
sys 0m0.006s

with siw
# time nvme reset /dev/nvme0
real 0m0.097s
user 0m0.000s
sys 0m0.006s

This is only reproducible with mlx IB card, as I mentioned before, the
reset operation time changed from 3s to 12s after the below commit,
could you check this commit?

commit 5ec5d3bddc6b912b7de9e3eb6c1f2397faeca2bc
Author: Max Gurtovoy <maxg@mellanox.com>
Date:   Tue May 19 17:05:56 2020 +0300

    nvme-rdma: add metadata/T10-PI support


>


-- 
Best Regards,
  Yi Zhang


