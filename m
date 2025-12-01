Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DC3CCFD376
	for <linux-nvme@archiver.kernel.org>; Mon,  1 Dec 2025 02:41:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Z4ueRZDGEmZN3pKdDV+VUbfm/GEWq1+GkEBdKVjZOtc=; b=vQTIKgO/0SmS0CeJUDjmqMI8cH
	fzPbry9yz/T3IPqjZT4/loRSBcV76EG7IzrFrLJp8EfjFR25orV8sGD+hcNALdXz+38eZXIG3eMls
	zpCKG+nAZum1LSEhaPpiacbEu5e2xsXgO4JniNW1oPwhuXzSdf4Fwg/pQzQOIih63On6caLOcTeTb
	zO2Rwr0jBrBUHvIXkrgK4FRCzw4hWhBg6VJZS+q34pgKFPj535+0XseoCygZFM5iVIrWLNKq0Ujbr
	fMfIkRplobOMBPtMbxJsPHGDwzol/hljTOMt6JPshAkr3zqS7KOZQD09HMHBoNgTjKriVMH0cLR6G
	kP3iV1Xw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vPtrI-00000002pKS-3JlQ;
	Mon, 01 Dec 2025 02:41:48 +0000
Received: from mail-qt1-x82b.google.com ([2607:f8b0:4864:20::82b])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vPtrF-00000002pK1-1cfM
	for linux-nvme@lists.infradead.org;
	Mon, 01 Dec 2025 02:41:46 +0000
Received: by mail-qt1-x82b.google.com with SMTP id d75a77b69052e-4edf1be4434so24865181cf.1
        for <linux-nvme@lists.infradead.org>; Sun, 30 Nov 2025 18:41:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764556904; x=1765161704; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z4ueRZDGEmZN3pKdDV+VUbfm/GEWq1+GkEBdKVjZOtc=;
        b=Ro65yU2FcjlKi8pSNAUC1snPgt/WECppJrscoKOKHGk7R+3Hmao2bCWnbQo1kBQ3Hv
         lGT6coNjlOQeLR13rS00jwuKfzkVyGM10DRIAzk4wltxh1zUVkXLgT+lAQt0Biod10dg
         IQ51RmgMNihJWiM8qPMpC1258LpzHQxQyaESbBK6MY23ENjQhwc52/nb0CoztPtg/kNm
         6DtEcZ2O3pQn2+qyRhGV0GGd4klEyD0HOfSs37yduIbY4f9kX8AudJHDluE2jpfjmunR
         vFRFjarPBZf8d1TX8PW4XaY2uJ+pLfsuSzvYOBSoAarlPqCvipt3RQeVEa6PnRSwAv3b
         jbrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764556904; x=1765161704;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Z4ueRZDGEmZN3pKdDV+VUbfm/GEWq1+GkEBdKVjZOtc=;
        b=smIs3yxWSdfp8uNYcpxTXFhbnS4ZCakpGxTILapQU+i5cDjwZHAjWJQydQmBNG9otD
         7ie6SupJxdoRZncwCC4eAdsEMddnv6ZuRnKGL/i86/rai6tUNGNVl7hdwIS0RNWNiUZW
         iE74Uu72ZBoPTL2foA91phuU5THllNXr6SsxEMS25KODdkE0hLI+zKvUP11m+XPgpJ19
         HaWGgYb7EqSwop25XdzEPC3AmS2+eKNXjltVe8572oI1Vq5LPGrdWhIkg4phONRzVP+d
         n2A1KEaQEhhNpZVcto8W/SdcEu1IsoK5JyD1WKrDspeUhB/ptDRR+Z/LXZtosgPdUd+x
         swZA==
X-Forwarded-Encrypted: i=1; AJvYcCXlXN1GmcxWH0HMnp9JesL8w2aFsDLj5AJLbObAECSutmm/bKkQT8sqmo4h2xdO8e9HbOWW6UvFMzg1@lists.infradead.org
X-Gm-Message-State: AOJu0YyEUysDu1LmZwYasFyJrsmondnpmveq6UyvHhpratl6g+fBW0uB
	0RWhif9Du0cxCtaDd5Vq8z88zMDFv+WZcVl1WIwKP+e5WNVWNt+xXgXzev2tEahC3qUO279rCSO
	GUI15fio0p6xAJ33sSpZ5udiZbiAE/sQ=
X-Gm-Gg: ASbGncvo4oGLthzCrWkxZr+WByaUOHiCJYgNbyPy7TZnGBl+dCC0gu7e4AcoGAqIBvm
	WB6qorviug3FwkNDlbMLd2Qi26LVQiyn4KREuCPDS8lHQOjR+8dtQjz02FwgK0IlHidSFVE5vWm
	HoSQRYbnlgEaszMUFFcysrAT9j1mIXqcPB2nthDQCqUw2WzMCh0y3e1WzkZ6uSt65b2Aj9RfJ21
	CFHPmvu2BkWv9f/Gq4iaRJX9v96vmgowBILCXQR1Q4FKa8/1YCXtsC82x6rJ74yfgetbjs=
X-Google-Smtp-Source: AGHT+IEmvBJytrUYv3PRff54NTqLEiIVWOTOdu8c+jgIKKnb+TW+2xLZqLXPCQhWGcR80rf7EC5pZtRoolK6Jl03Lrg=
X-Received: by 2002:a05:622a:14ce:b0:4ee:ce1:ed8a with SMTP id
 d75a77b69052e-4efbd91573emr353928791cf.16.1764556903722; Sun, 30 Nov 2025
 18:41:43 -0800 (PST)
MIME-Version: 1.0
References: <20251128083219.2332407-1-zhangshida@kylinos.cn>
 <20251128083219.2332407-13-zhangshida@kylinos.cn> <b33b3587-edb0-4f30-a8ee-baaa2b631ed9@grimberg.me>
In-Reply-To: <b33b3587-edb0-4f30-a8ee-baaa2b631ed9@grimberg.me>
From: Stephen Zhang <starzhangzsd@gmail.com>
Date: Mon, 1 Dec 2025 10:41:06 +0800
X-Gm-Features: AWmQ_blj_C1mdvu7tNb0hVlGGZGM9DWXbWPpg6J4BwD_02XuZ0ipoM_caXqdy_E
Message-ID: <CANubcdWAk2Mh5b9stjTh8N84jq+XAgaR3n2-VYRinU9ERtJLUw@mail.gmail.com>
Subject: Re: [PATCH v2 12/12] nvmet: use bio_chain_and_submit to simplify bio chaining
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Johannes.Thumshirn@wdc.com, hch@infradead.org, ming.lei@redhat.com, 
	linux-block@vger.kernel.org, linux-bcache@vger.kernel.org, 
	nvdimm@lists.linux.dev, virtualization@lists.linux.dev, 
	linux-nvme@lists.infradead.org, gfs2@lists.linux.dev, ntfs3@lists.linux.dev, 
	linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	zhangshida@kylinos.cn, Andreas Gruenbacher <agruenba@redhat.com>, 
	Gao Xiang <hsiangkao@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251130_184145_449198_6F0436D9 
X-CRM114-Status: UNSURE (   7.61  )
X-CRM114-Notice: Please train this message.
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

Sagi Grimberg <sagi@grimberg.me> =E4=BA=8E2025=E5=B9=B412=E6=9C=881=E6=97=
=A5=E5=91=A8=E4=B8=80 07:03=E5=86=99=E9=81=93=EF=BC=9A
>
> Acked-by: Sagi Grimberg <sagi@grimberg.me>

Hello,

I already dropped this patch in v3:
https://lore.kernel.org/all/20251129090122.2457896-1-zhangshida@kylinos.cn/
The reason is that the order of operations is critical. In the original cod=
e::
----------------
...
bio->bi_end_io =3D nvmet_bio_done;

for_each_sg(req->sg, sg, req->sg_cnt, i) {
...
          struct bio *prev =3D bio;
....
          bio_chain(bio, prev);
          submit_bio(prev);
}
----------------

the oldest bio (i.e., prev) retains the real bi_end_io function:

bio -> bio -> ... -> prev
However, using bio_chain_and_submit(prev, bio) would create the reverse cha=
in:

prev -> prev -> ... -> bio

where the newest bio would hold the real bi_end_io function, which does not
match the required behavior in this context.

Thanks,
Shida

