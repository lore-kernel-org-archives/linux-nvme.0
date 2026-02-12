Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4E5FECD6FE
	for <linux-nvme@archiver.kernel.org>; Thu, 12 Feb 2026 01:49:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=gTMYQimxZE07uJIVDpB8M+NDxbJyD2Nu8CEyKbpP4FA=; b=kBc4D2EqZL7/N1GSBGxLMItUmY
	7fZmBzAb5C/yPRO0xReZB97zsg/oF3OTkBEBGSGvW5/+dbctRfeyczInmw15gdV/7//tv3WP9uESd
	mZNJI3T1lIINV9M/bqDLv3WA5N7U8vKLYp0cC5BI5h94GPlPXahkQJ3UqYzgRSBk/Ae/nTGcamTHh
	i+vPgdBk2Q2EFOhdzelZ0B+94SegTWbK7SMd3KLuOlrFYUKOg2xApyN+WfElrP38B0vfTQ9SQzO1A
	mzvMM4daPIqDA4KBFFPAOySMFv3qzFiKGsgqs06bZWHVD1IKpvcpsc+KiYY+mwk2aGx6MdAXTAyJl
	GCqIlCsg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vqLpw-00000001HmD-2Jtz;
	Thu, 12 Feb 2026 01:49:44 +0000
Received: from mail-pg1-x536.google.com ([2607:f8b0:4864:20::536])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vqLpr-00000001Hls-2haE
	for linux-nvme@lists.infradead.org;
	Thu, 12 Feb 2026 01:49:42 +0000
Received: by mail-pg1-x536.google.com with SMTP id 41be03b00d2f7-c6e1e748dc1so340857a12.1
        for <linux-nvme@lists.infradead.org>; Wed, 11 Feb 2026 17:49:39 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770860978; cv=none;
        d=google.com; s=arc-20240605;
        b=DO/SxNvnbznWNEMAqE1b1juaZgwv3ovkrllZXsDVgTlDCkx+2FoaLwG+B3OIGJHLxg
         4K+Gtwt4VhjACduhsaujj/FBtc4nHUL9NZBX26Sx2ZMshQN4qebTufbUKiiJHec1Odut
         T8ZwMqCeMsUJRbf4LX6XC1hTXNZ7LV+lUTtXJSiy991f2cHQLyk7cF5q6MkkIJQfJ30T
         zRkGcA2PzVjZv493AyuHn+AZjPYkfMku83ybcR0tPA9fg7sy9tpnOUC18rf6WWmPL7KO
         RVPBJcpVLBOW9FAjzXV3MZFtim/TyTBb/sAyEwsz66TxIzk2JXefJ6ZtertMbSajYoNL
         x7vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=gTMYQimxZE07uJIVDpB8M+NDxbJyD2Nu8CEyKbpP4FA=;
        fh=m3NV7KzDGsAQ79DMZkla1VjSLM91BwANPrAX8RCv5k0=;
        b=YzO8j98nsC3uoYTyoIUuIf9PN3d2Xv6xo78R057HQnFdOQ57igxyds+awK8HzUlgEn
         +TcNW5a+yWIrAPZU/VRPx8ZtFi0Pv0mCdvGm0pCNBPSZgmrpcPJaaA56B9aHrSfzkYbc
         hFxRevSFJGJiosJ5Cw4eW+JxGLpkfWP3YqfG9e9Yp/y9y2Qgjy0PZfKJiP0/Bw67mQzX
         8BYLMGUA0UuZ+4uBiRQ1p61JpZy26RMktwsB3Mw6fDhzKgAHZZcqmmnIQ23KrACpZ97j
         yHn2sIiTzW86Ivm/L6OGraBqfsTjJ5R7iriXwha1eI2WPozArMchdHcd87TX6b4dOGPb
         cNrg==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770860978; x=1771465778; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gTMYQimxZE07uJIVDpB8M+NDxbJyD2Nu8CEyKbpP4FA=;
        b=AQBuXEXPF36rfG/L8enbfrUmn0rx1fSFPKedDXVVulUjkHyfmJ0VEyWhR8GXM/hRML
         IBcjCnJ7dKaajfLt5WLtg0yGheJbHIAUWddCTBiovQ5x2FAWcxq+zwAHZtfgmepuuzd/
         C6arOsui8eaMhEh8ZGiqI4Trok3D7Tpmd9fmQODhLSnysIVlKDXgJjcl42f6qJO/ecmw
         vEyYRiqJHqjWfiA4FC/2yg9DGO9kaOF0RvMmpUP2cFuwJJ/K9kNFcWpx+jX6wWSjZGEN
         cjaon3SngqpAMU3oh7y7lB18g5X0HD2J/WQgEerWtwMpwQKyYIGsDX+4IT6+c4QC+77Q
         Bd2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770860978; x=1771465778;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gTMYQimxZE07uJIVDpB8M+NDxbJyD2Nu8CEyKbpP4FA=;
        b=Ox+fnvc2iTCJpajBEq84K3HeXqN/C+2nrwC3lQx68k7OR9t8Juid21tzDytw9Sxe2w
         xs4pfJpjrFRHHNBsnPnzvzhllkySMoGggcS09B4Vd+WPhBdQxW7fSo4EpMBbKHAtidtr
         gZA5LR2X+ucvjA1TCPwYOBuMm9Pb81j8ae6rk3aF7eoEpgyOLuSHyb46L4OB+w7Qd9Dn
         m7zaU+nSNeHtduO/d/f7XaMaP0P8zVcYK0ZZbS4F8jSA9JKgKzR0y2RrscI/6XtVBkI3
         aNm9kmkTzovsS0gg3BSpNSnD+J+ET7dY781eSfz5MP2oN7N82q8/UxsMvdrHCdeN7TXu
         w+5Q==
X-Forwarded-Encrypted: i=1; AJvYcCVTAWanZR7/UHVGJO2TvT526o5/20kfi27ZL+FA/cYedLXAzR9BRAUkDIvYAIRd9upatzdqZdLAZVBi@lists.infradead.org
X-Gm-Message-State: AOJu0YwfY9N++8ZdjFzplupdzLlcAQFMqVsYnKdmDE9bAti1dz9MoKN8
	2ZKv9GHBt7jA2n5zQI9KAcX0KXW0SvnUPsO1/fWXXE9bi+UjiOyHnShHLXLWNifII8sSA4vXl7H
	G6zE3K0A7Soix2GgogdI2skStq+COduCin8Y9LG0=
X-Gm-Gg: AZuq6aKFYCcXlQX2ULiOsyAavfyoDmuuUUcluB0Ec0jsErjRqWsOCcSJvLOXiPLiBuP
	99KrU/ulBTUfP67TrEYhV3hPrbAPOw+dsm6aJjqbOZWbqFP8lv3xIHhrVlttXLAcOBFFHFiKy1f
	5GMA1WWT9tXRvyafjphTBgaftSIIilxanULgVqZAl/F7uQwT10yz2Lbw/3a6GiaHZ8VcVUXi/Kg
	Ch1dWeVxqoRA2XEO94ofqc4+TE8+b8lhoAX6miDkTRS2WOeUipsaMhbceKWfLsvrmWqNBIoWcFr
	n05M77XPcjK0pSAhHCoW
X-Received: by 2002:a17:90b:5863:b0:356:20fc:574d with SMTP id
 98e67ed59e1d1-35692d4a2d6mr744053a91.18.1770860978144; Wed, 11 Feb 2026
 17:49:38 -0800 (PST)
MIME-Version: 1.0
References: <20260211065925.2878336-1-ioerts@kookmin.ac.kr>
In-Reply-To: <20260211065925.2878336-1-ioerts@kookmin.ac.kr>
From: yunje shin <yjshin0438@gmail.com>
Date: Thu, 12 Feb 2026 10:49:27 +0900
X-Gm-Features: AZwV_QhIN7F49vI_qCfWHX7wMtA9bolQOZzRwKRkGU0PcDvsfBBNz4p1rVint-4
Message-ID: <CAMX6_QEQ0MZTPv3+ma6cESW6sXrzHSNttoRTY5wNf9p98caa8A@mail.gmail.com>
Subject: Re: [PATCH] nvmet: auth: validate dhchap id list lengths(KASAN: slab-out-of-bounds)
To: Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
	Chaitanya Kulkarni <kch@nvidia.com>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org, 
	linux-kernel@vger.kernel.org, ioerts@kookmin.ac.kr
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260211_174939_715432_EFDBC807 
X-CRM114-Status: GOOD (  20.55  )
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

The function nvmet_auth_negotiate() parses the idlist array in the
struct nvmf_auth_dhchap_protocol_descriptor payload. This array is 60
bytes and is logically divided into two 30-byte halves: the first half
for HMAC IDs and the second half for DH group IDs. The current code
uses a hardcoded +30 offset for the DH list, but does not validate
halen and dhlen against the per-half bounds. As a result, if a
malicious host sends halen or dhlen larger than 30, the loops can read
beyond the intended half of idlist, and for sufficiently large values
read past the 60-byte array into adjacent slab memory, triggering the
observed KASAN slab-out-of-bounds read.

This patch fixes the issue by:
    - Computing the half-size from sizeof(idlist) (idlist_half)
instead of hardcoding 30
    - Validating both halen and dhlen are within idlist_half
    - Replacing the hardcoded DH offset with idlist_half

Thanks,
Yunje Shin

On Wed, Feb 11, 2026 at 3:59=E2=80=AFPM YunJe Shin <yjshin0438@gmail.com> w=
rote:
>
> Validate DH-HMAC-CHAP hash/DH list lengths before indexing the idlist hal=
ves to prevent out-of-bounds reads.
>
> KASAN report:
> [   37.160829] Call Trace:
> [   37.160831]  <TASK>
> [   37.160832]  dump_stack_lvl+0x5f/0x80
> [   37.160837]  print_report+0xd1/0x640
> [   37.160842]  ? __pfx__raw_spin_lock_irqsave+0x10/0x10
> [   37.160846]  ? kfree+0x137/0x390
> [   37.160850]  ? kasan_complete_mode_report_info+0x2a/0x200
> [   37.160854]  kasan_report+0xe5/0x120
> [   37.160856]  ? nvmet_execute_auth_send+0x19a9/0x1f00
> [   37.160860]  ? nvmet_execute_auth_send+0x19a9/0x1f00
> [   37.160863]  __asan_report_load1_noabort+0x18/0x20
> [   37.160866]  nvmet_execute_auth_send+0x19a9/0x1f00
> [   37.160870]  nvmet_tcp_io_work+0x17a8/0x2720
> [   37.160874]  ? __pfx_nvmet_tcp_io_work+0x10/0x10
> [   37.160877]  process_one_work+0x5e9/0x1020
> [   37.160881]  ? __kasan_check_write+0x18/0x20
> [   37.160885]  worker_thread+0x446/0xc80
> [   37.160889]  ? __pfx_worker_thread+0x10/0x10
> [   37.160891]  kthread+0x2d7/0x3c0
> [   37.160894]  ? __pfx_kthread+0x10/0x10
> [   37.160897]  ret_from_fork+0x39f/0x5d0
> [   37.160900]  ? __pfx_ret_from_fork+0x10/0x10
> [   37.160903]  ? __kasan_check_read+0x15/0x20
> [   37.160906]  ? __switch_to+0xb45/0xf90
> [   37.160910]  ? __switch_to_asm+0x39/0x70
> [   37.160914]  ? __pfx_kthread+0x10/0x10
> [   37.160916]  ret_from_fork_asm+0x1a/0x30
> [   37.160920]  </TASK>
> [   37.160921]
> [   37.174141] Allocated by task 11:
> [   37.174377]  kasan_save_stack+0x3d/0x60
> [   37.174697]  kasan_save_track+0x18/0x40
> [   37.175043]  kasan_save_alloc_info+0x3b/0x50
> [   37.175420]  __kasan_kmalloc+0x9c/0xa0
> [   37.175762]  __kmalloc_noprof+0x197/0x480
> [   37.176117]  nvmet_execute_auth_send+0x39e/0x1f00
> [   37.176529]  nvmet_tcp_io_work+0x17a8/0x2720
> [   37.176912]  process_one_work+0x5e9/0x1020
> [   37.177275]  worker_thread+0x446/0xc80
> [   37.177616]  kthread+0x2d7/0x3c0
> [   37.177906]  ret_from_fork+0x39f/0x5d0
> [   37.178238]  ret_from_fork_asm+0x1a/0x30
> [   37.178591]
> [   37.178735] The buggy address belongs to the object at ffff88800aecc80=
0
> [   37.178735]  which belongs to the cache kmalloc-96 of size 96
> [   37.179790] The buggy address is located 0 bytes to the right of
> [   37.179790]  allocated 72-byte region [ffff88800aecc800, ffff88800aecc=
848)
> [   37.180931]
> [   37.181079] The buggy address belongs to the physical page:
> [   37.181572] page: refcount:0 mapcount:0 mapping:0000000000000000 index=
:0x0 pfn:0xaecc
> [   37.182393] flags: 0x100000000000000(node=3D0|zone=3D1)
> [   37.182819] page_type: f5(slab)
> [   37.183080] raw: 0100000000000000 ffff888006c41280 dead000000000122 00=
00000000000000
> [   37.183730] raw: 0000000000000000 0000000000200020 00000000f5000000 00=
00000000000000
> [   37.184333] page dumped because: kasan: bad access detected
> [   37.184783]
> [   37.184918] Memory state around the buggy address:
> [   37.185315]  ffff88800aecc700: fa fb fb fb fb fb fb fb fb fb fb fb fc =
fc fc fc
> [   37.185835]  ffff88800aecc780: fa fb fb fb fb fb fb fb fb fb fb fb fc =
fc fc fc
> [   37.186336] >ffff88800aecc800: 00 00 00 00 00 00 00 00 00 fc fc fc fc =
fc fc fc
> [   37.186839]                                               ^
> [   37.187255]  ffff88800aecc880: fa fb fb fb fb fb fb fb fb fb fb fb fc =
fc fc fc
> [   37.187763]  ffff88800aecc900: fa fb fb fb fb fb fb fb fb fb fb fb fc =
fc fc fc
> [   37.188261] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> [   37.188938] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> Fixes: db1312dd95488 ("nvmet: implement basic In-Band Authentication")
> Signed-off-by: YunJe Shin <ioerts@kookmin.ac.kr>
> ---
>  drivers/nvme/target/fabrics-cmd-auth.c | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/nvme/target/fabrics-cmd-auth.c b/drivers/nvme/target=
/fabrics-cmd-auth.c
> index 5946681cb0e3..8ad3255aec4a 100644
> --- a/drivers/nvme/target/fabrics-cmd-auth.c
> +++ b/drivers/nvme/target/fabrics-cmd-auth.c
> @@ -36,6 +36,7 @@ static u8 nvmet_auth_negotiate(struct nvmet_req *req, v=
oid *d)
>         struct nvmet_ctrl *ctrl =3D req->sq->ctrl;
>         struct nvmf_auth_dhchap_negotiate_data *data =3D d;
>         int i, hash_id =3D 0, fallback_hash_id =3D 0, dhgid, fallback_dhg=
id;
> +       size_t idlist_half;
>
>         pr_debug("%s: ctrl %d qid %d: data sc_d %d napd %d authid %d hale=
n %d dhlen %d\n",
>                  __func__, ctrl->cntlid, req->sq->qid,
> @@ -72,6 +73,15 @@ static u8 nvmet_auth_negotiate(struct nvmet_req *req, =
void *d)
>             NVME_AUTH_DHCHAP_AUTH_ID)
>                 return NVME_AUTH_DHCHAP_FAILURE_INCORRECT_PAYLOAD;
>
> +       /*
> +        * idlist[0..idlist_half-1]: hash IDs
> +        * idlist[idlist_half..]: DH group IDs
> +        */
> +       idlist_half =3D sizeof(data->auth_protocol[0].dhchap.idlist) / 2;
> +       if (data->auth_protocol[0].dhchap.halen > idlist_half ||
> +           data->auth_protocol[0].dhchap.dhlen > idlist_half)
> +               return NVME_AUTH_DHCHAP_FAILURE_INCORRECT_PAYLOAD;
> +
>         for (i =3D 0; i < data->auth_protocol[0].dhchap.halen; i++) {
>                 u8 host_hmac_id =3D data->auth_protocol[0].dhchap.idlist[=
i];
>
> @@ -98,7 +108,8 @@ static u8 nvmet_auth_negotiate(struct nvmet_req *req, =
void *d)
>         dhgid =3D -1;
>         fallback_dhgid =3D -1;
>         for (i =3D 0; i < data->auth_protocol[0].dhchap.dhlen; i++) {
> -               int tmp_dhgid =3D data->auth_protocol[0].dhchap.idlist[i =
+ 30];
> +               int tmp_dhgid =3D
> +                       data->auth_protocol[0].dhchap.idlist[i + idlist_h=
alf];
>
>                 if (tmp_dhgid !=3D ctrl->dh_gid) {
>                         dhgid =3D tmp_dhgid;
> --
> 2.43.0
>

