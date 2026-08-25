Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C19BC5DF81
	for <linux-nvme@archiver.kernel.org>; Tue, 25 Aug 2026 00:21:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=mbM6YJjwg5HWZh1D5mfQrLhKRwcyWyJHCXub5R5k3vQ=; b=xy/YzOwTEjcPqB1MpHDJw0yjWz
	WBTddjim/9kzqjZfCaTds15L8GPVYc7A1fej9WbyTfWo+cDv8ghuEUcF7XQwUJAhK/vb1TxYQPE6Z
	MIBSgTcjtCaHZiBZAM4DTviDUdoM8PGAKixtboYe3rGyj6yGbXHgRYhhAQob1dzspD+MGhgfF8Oc2
	r1OqsAc2i/xu73VZyyHd3y9iZdSfarqrDGsAgPRVlBffj+oxzV4Lyu7eDYuAjfH/UeO1I5b/Xm+ef
	w3CRbRZ50NrgAaOI0XU3Y05TV8oW4HULfnJvbuJU1J1qImmw2a4r6kKtBI2XsMVbUvwn0L+Ai7MVE
	oGIx/5wQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wyev8-0000000HXNb-36HE;
	Tue, 25 Aug 2026 00:21:42 +0000
Received: from mail-vs1-xe2e.google.com ([2607:f8b0:4864:20::e2e])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wyev6-0000000HXMg-0Lb3
	for linux-nvme@lists.infradead.org;
	Tue, 25 Aug 2026 00:21:41 +0000
Received: by mail-vs1-xe2e.google.com with SMTP id ada2fe7eead31-77e354fa83aso491476137.3
        for <linux-nvme@lists.infradead.org>; Mon, 24 Aug 2026 17:21:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787617298; cv=none;
        d=google.com; s=arc-20260327;
        b=d3Vw3kqlgW5avPy0qjCebUuDqgr/GKUEumycoQulj8YCHcwPjOjWqKgs8y478nSp4I
         +0oA1hqxAK7G135al21tIT4OfYbVy14/J5R9kG0zVc/SlbdaKkwk0bMFVYFbZ+kSt0QM
         1bjAntvk6O3ch4IGbdpAhWDb1SwmM8UamNSs+kP1NVjlVRlIjo0Ho3A/GOOaCeVXB1k5
         RhIKrYQrJggV6AIDQ/wyLq+VmuZ4XT4ziR4ZqvgjHfDQTOMIpoCOdm6Dh8IZZ8crpewh
         VPY3413o73CQdYsyJvXYi2qOMs8QTcTTLV8zB+g9XEutKcjEnw7Wl8w82Cwf9bGMdI+Q
         hA7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=mbM6YJjwg5HWZh1D5mfQrLhKRwcyWyJHCXub5R5k3vQ=;
        fh=UbiK1hkua2tD6YCQzOhKTdUxBffBGJ6SSPhmb0t1p5g=;
        b=oQSnCC10EAW0UaNEviWYAWFVHmkEES9uv371UAWOaPY2e1djizhHvOgCTspQvEBXXF
         90lmvWfGgChwAjjOwLyomkQcpzdSW6i2lTV5ZulrReCjuA8Wf7K6J9JRGBmY273vEo2l
         sdQKMEQBSLccVo0AXcGd+Szvx2WZiG9lxqu0nRMRRXzRwQvwWryE6KdNsqXUa5FawXY6
         /sNwpDEA2ue8wTerglDwI+2PxGAOERKWg4no1cnAzg48oyHdTgVM0zIqMk2HhQ/VO/8m
         Wu/kRtmUwrRqCvS7ar1NNMYGzvtq0G8F3K+awXS0vSylMM1ILHrTG1H8scpHdp9D22ac
         K3dg==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1787617298; x=1788222098; darn=lists.infradead.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=mbM6YJjwg5HWZh1D5mfQrLhKRwcyWyJHCXub5R5k3vQ=;
        b=J/m1O9DoWcPF0HNFJohN40haBuDXWE4OCanPoGPBTo1KZ5zGxFp036vm3744ftxbO9
         flTkUusrSz8Gw7mn+YjjxKe2PO7hr23S6PGv1IDWEBWDbDoao3/ImJI6B/BLqTHM9b5K
         llifmZ6JYlhDfSUf8UzsamKUcSPfe0l4u48K7GQvCmrvF+TW8UrBlS9W8Xl+vRN0Yf2n
         gttp3nMA9x3UQ9ax3jzDpQPSl5eAl2EKwpBPTsnJd+wIBVs6yXHVs59DnEfP1NGt/cRQ
         k8H5nkvJktD8uRHyJJfM7B00ZkT/M4DKTeTZS3wVQpEpuP1+YcefBrOR5qwGfQZOL4Je
         0ZKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787617298; x=1788222098;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mbM6YJjwg5HWZh1D5mfQrLhKRwcyWyJHCXub5R5k3vQ=;
        b=AwdHtzTFwi7q4zY803borRAg1SeVaqAeKqRampMPQsVlhBEDeeLTgkdKTnhyhPeg9R
         AMcvAtuq8bEMju+IMNVKiDwMNVaCrGx4ulX/jolKOaXKEXFNn7jlWYpeZ4qmTSAbI0Da
         gVmDthIvig7BSZJlMb8EsZ0ZEc2YgNKrN1NBdcIYh4u14/q3B5ucA+2UHz0FshW1DLzF
         3aXJ1mXBffbP84dekNB70n6YC7nMm/dJwkBoCYG0wEfZEsVGKl07eSMy5SVO6ZVgw1F3
         a3zZJB04ibUBgtQ5t1ucyTBEb5klbWm++lXDGGC3MXc8nJYAYUnQRjtkN3c9xYLGSrNb
         kBCA==
X-Forwarded-Encrypted: i=1; AHgh+RpRWiIvArxK3agQjvHihfko0sC2TJIqhuuLyHa/Tk5PKMpId6WNrl3icy6YZWNerR3YzJxVWioVwhgv@lists.infradead.org
X-Gm-Message-State: AFuF++kTPee2XqurQnv70daJw2P6DBxpKAeynIOsKqKibRiDZjbw2a4G
	0WHwEJ4nX5+g8SV+fG1T6DR4Foiui8FRrv2xC/+3x78no8bd8fp8Cc3E3PXx42kfDFxdtK+UNEV
	5nG4e7SsdladtJUsfIx/45wVv2e/lmJr6JSuPBO5qhQ==
X-Gm-Gg: AR+sD12d3RIepcTgTv2cWCjfIZfs61JnSEm8Y7zVLZVGsfbVJ2umLxIV4pENoe3yhK7
	QE1jMcs0W+teawFJ0sn3vB5HBXb+oNs/qCu/OlTA+IJBXsat2ENO9a9ydBer8DJvwtSgo6IX0sr
	2ZIyRe/eJ14mzrdjOcgVLeVWtISYK1/yi4L0Rc2m/kx/8YJYZxoPqp/K7b6HdJsCzimYzYNkRDk
	4aQLC1NruCaoZ1qbV2BYkZVywKbUw+lSFa7KUumUjEtBZhV19SYj9woTPb0U3FMJK+SQjvzWtAr
	HVL2wSkgqp+Ww9bDYU9jKGxiPiNXyMoT1Uv/af1Ra7xEh7OGMq83Uft71XoPMEMq5KjIamNxJfW
	yf6yvT4gScjh9lpbksv1/SLC4FTvX3Eg=
X-Received: by 2002:a05:6102:4b14:b0:77e:6f90:4aad with SMTP id
 ada2fe7eead31-77e6f90535amr3213086137.2.1787617298472; Mon, 24 Aug 2026
 17:21:38 -0700 (PDT)
MIME-Version: 1.0
References: <20260823004641.1369895-1-mkhalfella@purestorage.com>
In-Reply-To: <20260823004641.1369895-1-mkhalfella@purestorage.com>
From: Randy Jennings <randyj@purestorage.com>
Date: Mon, 24 Aug 2026 17:21:26 -0700
X-Gm-Features: AcwNN1Wtc5w2YkliLi5LprD8Jgv2ZD7DLTAvMtO9X1z4qsD2A6UASXPO1XEZqh8
Message-ID: <CAPpK+O0e5HhDHEnu6uUw5AgtJfFoXjCmB2Q+13QDz1HtSdgDUQ@mail.gmail.com>
Subject: Re: [PATCH v2] nvme: remove stale namespaces by NSID range during scan
To: Mohamed Khalfella <mkhalfella@purestorage.com>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, 
	Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260824_172140_129059_6A51CEF5 
X-CRM114-Status: GOOD (  19.67  )
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

On Sat, Aug 22, 2026 at 5:47=E2=80=AFPM Mohamed Khalfella
<mkhalfella@purestorage.com> wrote:
>
> nvme_scan_ns_list() drops the stale namespaces in each gap in the
> reported NSID list one NSID at a time. Every iteration calls
> nvme_find_get_ns() to look the namespace up and removes it if it is
> present. The loop runs once per NSID in the gap rather than once per
> namespace actually present.
>
> NSIDs are 32-bit, so a target with a sparse NSID space can make a
> single gap spin the loop billions of times with nothing to remove.
>
>   watchdog: BUG: soft lockup - CPU#4 stuck for 26s!
>   Workqueue: nvme-wq nvme_scan_work [nvme_core]
>   RIP: 0010:__srcu_read_unlock+0xb/0x20
>   Call Trace:
>    nvme_find_get_ns+0x7d/0xb0 [nvme_core]
>    nvme_scan_ns_list+0xe8/0x280 [nvme_core]
>    nvme_scan_work+0x18a/0x280 [nvme_core]
>    process_one_work+0x197/0x380
>    worker_thread+0x2fe/0x410
>    kthread+0xe0/0x100
>
> Rename nvme_remove_invalid_namespaces() to nvme_remove_nsid_range()
> and give it an open (start, end) NSID range. ctrl->namespaces is
> sorted by NSID, so the whole gap is dropped in a single walk that
> stops once end is reached. This bounds the work by the namespaces
> that are present instead of by the size of the gap.
>
> Fixes: 540c801c65eb ("NVMe: Implement namespace list scanning")
> Signed-off-by: Mohamed Khalfella <mkhalfella@purestorage.com>
> Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Reviewed-by: Randy Jennings <randyj@purestorage.com>

> ---
>  drivers/nvme/host/core.c | 18 +++++++++---------

> -static void nvme_remove_invalid_namespaces(struct nvme_ctrl *ctrl,
> -                                       unsigned nsid)
> +static void nvme_remove_nsid_range(struct nvme_ctrl *ctrl, u32 start, u3=
2 end)
It is not intuitive to me that start is non-inclusive.  May we add
a comment to that effect?

>  {
>         struct nvme_ns *ns, *next;
>         LIST_HEAD(rm_list);
>
>         mutex_lock(&ctrl->namespaces_lock);
>         list_for_each_entry_safe(ns, next, &ctrl->namespaces, list) {
> -               if (ns->head->ns_id > nsid) {
> +               if (ns->head->ns_id >=3D end)
> +                       break;
> +               if (ns->head->ns_id > start) {
>                         list_del_rcu(&ns->list);

