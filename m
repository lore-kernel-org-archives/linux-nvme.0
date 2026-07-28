Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CACFC53219
	for <linux-nvme@archiver.kernel.org>; Tue, 28 Jul 2026 07:52:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:References:From:
	Subject:Cc:To:Message-Id:Date:Content-Type:Content-Transfer-Encoding:
	Mime-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=HQAgkDQdWolCH1WdxjRLn++QDNlQqY1mhu2LSiV4TEw=; b=mqeTvKh1VHECRtPhbLMmYf28pf
	oxE/qGs/cFMzeV1YyCEdErFlqHjldL84GmtLBxj5GZtASP30IYD3P+QjRTrKX6OD+wNWwQNbBP+Ti
	tHPHjHkpTAldlpuNoJduwmsDp0B2naK4+e5uFcyU9h9HuokJ0nseR9dNySnvrhs2M09Bi2K7++Ljr
	5fBixF3IJdK4ovg8Z9VeWSIuTFWwA3301tasfq9IKMmM8lbOrv/sXd52Cf8qKutmY9oludcEoHvzR
	kZKdvOolFpihVV4jZIJJrAt7hYV9a2w8GHCI1lDHDEKlfLgwrQAgeh/DnqsrkFtd4XpPE4NiYAYEP
	cI2ux22w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1woccS-00000004fEw-2iM0;
	Tue, 28 Jul 2026 07:52:56 +0000
Received: from 128-116-240-228.dyn.eolo.it ([128.116.240.228] helo=arkamax.eu)
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1woccO-00000004fDO-2o0e
	for linux-nvme@lists.infradead.org;
	Tue, 28 Jul 2026 07:52:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; s=mail1; bh=ppilJn1kCzNmfA
	uDnPrcUc1O7jjR+vXpbMJbqEQVyvE=; h=in-reply-to:references:from:subject:
	cc:to:date; d=arkamax.eu; b=N2tvchLwr5WsKAAxXVSvMcXG+9N3SL9Xv/9N9EfSrl
	KRettjE1LuNh2HoGREvdH+BoZ7JmQG6kNp1b+DMQgKsdVrR/Wy0bn89F1V5O+SviJ1J8Ku
	l76qOVIXWcs7JPIuDv1NHRVJXGfnTwvm3nbLQw/4r6wQsIsCc5zqlDGNsWejAZQH/dRM+c
	nBFSFODtkMxbasJYH9ZYHuwfqm0/5Pb+W5EOWHVJIwwvKtIzkMmGs0LvwfnOxDi/FShVdJ
	JMjXkDaxEFuK6UBaXCwARMlUXNGQPZoW6HkZyLNcmwnZ4mlDHjD/peIXCm0JtobH4L+BPe
	J0WzaMM7GChbHhMECB1A==
Received: from localhost (<unknown> [193.207.213.85])
	by arkamax.eu (OpenSMTPD) with ESMTPSA id e52f5367 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 28 Jul 2026 09:52:46 +0200 (CEST)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 28 Jul 2026 09:52:44 +0200
Message-Id: <DKA1I6TD9OGB.2NXHE0G2W3A7V@arkamax.eu>
To: "Zhengrong Li" <zhengrong_li@linux.alibaba.com>,
 <linux-nvme@lists.infradead.org>
Cc: <hch@lst.de>, <sagi@grimberg.me>, <kch@nvidia.com>
Subject: Re: [PATCH] nvmet: fix Reservation Register Replace for
 unregistered host with IEKEY
From: "Maurizio Lombardi" <mlombard@arkamax.eu>
X-Mailer: aerc 0.21.0
References: <178521959386.52051.17173420094473200063@linux.alibaba.com>
In-Reply-To: <178521959386.52051.17173420094473200063@linux.alibaba.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260728_005253_348639_832C83D5 
X-CRM114-Status: GOOD (  18.25  )
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

On Sat Jul 25, 2026 at 5:50 AM CEST, Zhengrong Li wrote:
> When a host sends a Reservation Register command with RREGA=3DReplace
> and IEKEY=3D1 without being previously registered, nvmet returns
> Reservation Conflict.  SPDK accepts this combination and creates a
> new registrant with the provided NRKEY, with an explicit unit test
> covering this scenario (test/unit/lib/nvmf/subsystem.c).
>
> Fix nvmet_pr_replace() to add a new registrant when the host is not
> found in the registrant list and IEKEY is set with a non-zero NRKEY,
> consistent with SPDK's behavior.
>
> Tested with nvme-cli against nvmet-tcp:
>
>   # no prior registration
>   nvme resv-register /dev/nvmeXn1 -n 1 --rrega=3D2 --iekey --nrkey=3D0x99=
99
>
>   Before: RESERVATION_CONFLICT (0x4083)
>   After:  success, registrant created with rkey 0x9999

The SPDK behaviour seems to be correct, the spec indeed says that

"A host may replace
its reservation key without regard to its registration status or current re=
servation key value by setting the
Ignore Existing Key (IEKEY) bit to '1' in the Reservation Register
command."

>
> Signed-off-by: Zhengrong Li <zhengrong_li@linux.alibaba.com>
> ---
>  drivers/nvme/target/pr.c | 20 +++++++++++++++++++-
>  1 file changed, 19 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/nvme/target/pr.c b/drivers/nvme/target/pr.c
> index c71ae46244ff..f00de35683ca 100644
> --- a/drivers/nvme/target/pr.c
> +++ b/drivers/nvme/target/pr.c
> @@ -355,12 +355,14 @@ static u16 nvmet_pr_replace(struct nvmet_req *req,
>  	u16 status =3D NVME_SC_RESERVATION_CONFLICT | NVME_STATUS_DNR;
>  	struct nvmet_ctrl *ctrl =3D req->sq->ctrl;
>  	struct nvmet_pr *pr =3D &req->ns->pr;
> -	struct nvmet_pr_registrant *reg;
> +	struct nvmet_pr_registrant *reg, *new;
>  	u64 nrkey =3D le64_to_cpu(d->nrkey);
> +	bool found =3D false;
> =20
>  	down(&pr->pr_sem);
>  	list_for_each_entry_rcu(reg, &pr->registrant_list, entry) {
>  		if (uuid_equal(&reg->hostid, &ctrl->hostid)) {
> +			found =3D true;
>  			if (ignore_key || reg->rkey =3D=3D le64_to_cpu(d->crkey))
>  				status =3D nvmet_pr_update_reg_attr(pr, reg,
>  						nvmet_pr_update_reg_rkey,
> @@ -368,6 +370,22 @@ static u16 nvmet_pr_replace(struct nvmet_req *req,
>  			break;
>  		}
>  	}
> +
> +	if (!found && ignore_key && nrkey) {
> +		new =3D kmalloc_obj(*new);
> +		if (!new) {
> +			status =3D NVME_SC_INTERNAL;
> +			goto out;
> +		}
> +		memset(new, 0, sizeof(*new));

Just use kzalloc_obj()?

Maurizio

