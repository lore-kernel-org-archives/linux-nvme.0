Return-Path: <SRS0=tknV=IJ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCCC0C433DB
	for <linux-nvme@archiver.kernel.org>; Thu, 11 Mar 2021 05:51:54 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D4AC564FC4
	for <linux-nvme@archiver.kernel.org>; Thu, 11 Mar 2021 05:51:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4AC564FC4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=irrelevant.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	In-Reply-To:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Reply-To:Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date
	:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=z2DHeEtN02fLW2fWexFe7JuR3Wj+VBGcMj2B2zzhbcE=; b=hYOOMfG4MGL6UULeoLd6wTmhh
	FIQfYpiXxcapfBHDH1arK79WQeWSRgjmyDIBhkOdpNI1RXVDmaEbnrJC9h8sT4Y/CNf76yUI32VsK
	hh2a48SasshrctNzmyfiSU4Tt7vMthvyDhXRb969SnBjOHiypYN/UJBaI1mtlIF4ctlnjOF640Pk7
	+BON1hnW5IknLtJrHCtMW44riAaJYoeqPgLohRoNoIrm8f8sTRkrr/Jd/B5Z4z76xhxWn4VDJc2Or
	sPFuCS8fG8LkC+qeiCPTSV+Oc5fYm9BCFzs5RQrwV6j21ngMk+n4v6Y2ILwB91Nd3UGpVwV1GCioR
	bSXY1WRnA==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lKEEY-008Qbw-TU; Thu, 11 Mar 2021 05:51:42 +0000
Received: from out1-smtp.messagingengine.com ([66.111.4.25])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lKEES-008QaK-RG
 for linux-nvme@lists.infradead.org; Thu, 11 Mar 2021 05:51:40 +0000
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
 by mailout.nyi.internal (Postfix) with ESMTP id 42D365C00A7;
 Thu, 11 Mar 2021 00:51:30 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
 by compute4.internal (MEProxy); Thu, 11 Mar 2021 00:51:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-type:in-reply-to; s=fm2; bh=uAXLYJgVerjwxHJxGUU+EO/qsbX
 pEBE+Or681SrNQO8=; b=kfdStmuy1bURoyada2BLntBG3G+6XacmIoxIpiJSWMT
 GbbK00/07vjzoNwPY9Lqpq1/G9Rtpd+Y0XJERUfjFDmsdsVVFcWybl172a5ypIyT
 yM+Pt7mYDzIAT+H/tg4Wf1Mq6ms98riG3M06qnhKzKJfhH6c2unn0BAXNB17hFeH
 SX7p+3SBugf6C2o/9IOxln6ZYSDWBekBXfsBScBj0XerGRNFZswtJZ9K+dUMeQ4V
 1rW8P7Uwc4T21QLYCwENkruFcGGSnccFhVFl5NU5tikqCoIlXC86siaxOnKC4lqB
 kbgIb+l6DiUzaFWO3nR50csddit8C0VsXy26aR4A1fg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to:x-me-proxy
 :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=uAXLYJ
 gVerjwxHJxGUU+EO/qsbXpEBE+Or681SrNQO8=; b=pdEAIbivG53debuLHw7P7h
 u53VmKC3Y3571hv8bjxctpoWJPRA8MDwQqY+Un53knM0QWBE/U7BodQpul4CmLH1
 DojTC5OjKVEawBWNuP3U1XCu+Ielr8cOH3+CwX6kMqiptzmhnKMRWZTMz+vzDEG/
 B+j24Hh1ibhe8EQTt41Rn03DsrLokdc/l00QXDYT/18XJjOPO9xblPmGn9qqgKD5
 IZ9XYTcGx+kBITJoBVwquBTUUB37I7fy6pX/DwsGt8TKSvTQrDdKdR8buHo6ppet
 RVsenP7CZbW7fk0AxWq9AfRNKeLrx/IpdHCjI72IrRHohsRZq58IZOkXDiyCG11g
 ==
X-ME-Sender: <xms:4a9JYJrnNYJCPoqe2Ct9WKcYSyJ9TrWaX_sh8UMvGSN4WgQlfd1QMw>
 <xme:4a9JYLoU9jSYqHrKecNG5_oxP7_XqUceYcczAdbGussVqKhyCFDGhpjNhSAIEFUf6
 kJZBlj1HY5x4vIEDuw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrudduledgkeejucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhepfffhvffukfhfgggtuggjsehgtderredttdejnecuhfhrohhmpefmlhgruhhs
 ucflvghnshgvnhcuoehithhssehirhhrvghlvghvrghnthdrughkqeenucggtffrrghtth
 gvrhhnpedutdehleelvdetvdefueehgeevhfejueeliefhudfhiefffffhuddtkeekieek
 feenucffohhmrghinhepihhnfhhrrgguvggrugdrohhrghenucfkphepkedtrdduieejrd
 elkedrudeltdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhr
 ohhmpehithhssehirhhrvghlvghvrghnthdrughk
X-ME-Proxy: <xmx:4a9JYGNHPgL6i432nJv35LRYYzi-YM5522Ur8at77ywR148skIUupQ>
 <xmx:4a9JYE7Dztb_uaun762E57U487cwQa5nAs4bXIPUdnHWXrNIANjqsg>
 <xmx:4a9JYI4ArSUIlXNNo3Sx_QH3C8XKhPrCPjGNy4tqSRpLN4VqM_dL3w>
 <xmx:4q9JYIFR9lHl8aNJXVEdXryHiZOlX5ra5ZpwBfPZ3qrUj6rrSBiNsw>
Received: from apples.localdomain (80-167-98-190-cable.dk.customer.tdc.net
 [80.167.98.190])
 by mail.messagingengine.com (Postfix) with ESMTPA id 867F9108005C;
 Thu, 11 Mar 2021 00:51:28 -0500 (EST)
Date: Thu, 11 Mar 2021 06:51:26 +0100
From: Klaus Jensen <its@irrelevant.dk>
To: Keith Busch <kbusch@kernel.org>
Cc: linux-nvme@lists.infradead.org, sagi@grimberg.me, hch@lst.de
Subject: Re: [PATCH] nvme: implement non-mdts command limits
Message-ID: <YEmv3nNynyBHggoz@apples.localdomain>
References: <20210310195726.3377288-1-kbusch@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20210310195726.3377288-1-kbusch@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210311_055137_320615_7451F794 
X-CRM114-Status: GOOD (  32.51  )
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
Content-Type: multipart/mixed; boundary="===============4655385975750997871=="
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


--===============4655385975750997871==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="eXW5yKn+oC3g21lR"
Content-Disposition: inline


--eXW5yKn+oC3g21lR
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mar 10 11:57, Keith Busch wrote:
> Commands that access LBA contents without a data transfer between the
> host historically have not had a spec defined upper limit. The driver
> set the queue constraints for such commands to the max data transfer
> size just to be safe, but this artificial constraint frequently limits
> devices below their capabilities.
>=20
> The NVMe Workgroup ratified TP4040 defines how a controller may
> advertise their non-MDTS limits. Use these if provided, and default
> to the current constraints if not.
>=20
> Signed-off-by: Keith Busch <kbusch@kernel.org>
> ---
>  drivers/nvme/host/core.c | 89 +++++++++++++++++++++++++++++++---------
>  drivers/nvme/host/nvme.h |  3 ++
>  include/linux/nvme.h     | 10 +++++
>  3 files changed, 82 insertions(+), 20 deletions(-)
>=20
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index f7bc808da3d0..af299487f7a8 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -1939,7 +1939,7 @@ static void nvme_config_discard(struct gendisk *dis=
k, struct nvme_ns *ns)
>  	struct request_queue *queue =3D disk->queue;
>  	u32 size =3D queue_logical_block_size(queue);
> =20
> -	if (!(ctrl->oncs & NVME_CTRL_ONCS_DSM)) {
> +	if (!(ctrl->max_discard_sectors)) {
>  		blk_queue_flag_clear(QUEUE_FLAG_DISCARD, queue);
>  		return;
>  	}
> @@ -1957,8 +1957,8 @@ static void nvme_config_discard(struct gendisk *dis=
k, struct nvme_ns *ns)
>  	if (blk_queue_flag_test_and_set(QUEUE_FLAG_DISCARD, queue))
>  		return;
> =20
> -	blk_queue_max_discard_sectors(queue, UINT_MAX);
> -	blk_queue_max_discard_segments(queue, NVME_DSM_MAX_RANGES);
> +	blk_queue_max_discard_sectors(queue, ctrl->max_discard_sectors);
> +	blk_queue_max_discard_segments(queue, ctrl->max_discard_segments);
> =20
>  	if (ctrl->quirks & NVME_QUIRK_DEALLOCATE_ZEROES)
>  		blk_queue_max_write_zeroes_sectors(queue, UINT_MAX);
> @@ -1966,25 +1966,10 @@ static void nvme_config_discard(struct gendisk *d=
isk, struct nvme_ns *ns)
> =20
>  static void nvme_config_write_zeroes(struct gendisk *disk, struct nvme_n=
s *ns)
>  {
> -	u64 max_blocks;
> +	u64 max_blocks =3D ns->ctrl->max_zeroes_sectors;
> =20
> -	if (!(ns->ctrl->oncs & NVME_CTRL_ONCS_WRITE_ZEROES) ||
> -	    (ns->ctrl->quirks & NVME_QUIRK_DISABLE_WRITE_ZEROES))
> +	if (max_blocks =3D=3D 0)
>  		return;
> -	/*
> -	 * Even though NVMe spec explicitly states that MDTS is not
> -	 * applicable to the write-zeroes:- "The restriction does not apply to
> -	 * commands that do not transfer data between the host and the
> -	 * controller (e.g., Write Uncorrectable ro Write Zeroes command).".
> -	 * In order to be more cautious use controller's max_hw_sectors value
> -	 * to configure the maximum sectors for the write-zeroes which is
> -	 * configured based on the controller's MDTS field in the
> -	 * nvme_init_ctrl_finish() if available.
> -	 */
> -	if (ns->ctrl->max_hw_sectors =3D=3D UINT_MAX)
> -		max_blocks =3D (u64)USHRT_MAX + 1;
> -	else
> -		max_blocks =3D ns->ctrl->max_hw_sectors + 1;
> =20
>  	blk_queue_max_write_zeroes_sectors(disk->queue,
>  					   nvme_lba_to_sect(ns, max_blocks));
> @@ -3063,6 +3048,65 @@ static int nvme_get_effects_log(struct nvme_ctrl *=
ctrl, u8 csi,
>  	return 0;
>  }
> =20
> +static inline u32 nvme_mps_size_to_bytes(u8 size)
> +{
> +	/* XXX: modify if NVME_CTRL_PAGE_SHIFT ever changes */
> +	return 1 << (size + 3);
> +}
> +
> +static int nvme_init_non_mdts_limits(struct nvme_ctrl *ctrl)
> +{
> +	struct nvme_command c =3D { };
> +	struct nvme_id_ctrl_nvm *id;
> +	int ret;
> +
> +	if (!(ctrl->oncs & NVME_CTRL_ONCS_DSM)) {
> +		ctrl->max_discard_sectors =3D 0;
> +		ctrl->max_discard_segments =3D 0;
> +	} else {
> +		ctrl->max_discard_sectors =3D UINT_MAX;
> +		ctrl->max_discard_segments =3D NVME_DSM_MAX_RANGES;
> +	}
> +
> +	/*
> +	 * Even though NVMe spec explicitly states that MDTS is not applicable
> +	 * to the write-zeroes, we are cautious and limit the default size to
> +	 * the controller's max_hw_sectors value, which is based on the MDTS
> +	 * field and possibly other limiting factors.
> +	 */
> +	if (!(ctrl->quirks & NVME_QUIRK_DISABLE_WRITE_ZEROES) &&
> +	    (ctrl->oncs & NVME_CTRL_ONCS_WRITE_ZEROES))
> +		ctrl->max_zeroes_sectors =3D ctrl->max_hw_sectors;
> +	else
> +		ctrl->max_zeroes_sectors =3D 0;
> +
> +	if (ctrl->vs < NVME_VS(1, 2, 0))
> +		return 0;
> +
> +	id =3D kzalloc(sizeof(*id), GFP_KERNEL);
> +	if (!id)
> +		return 0;
> +
> +	c.identify.opcode =3D nvme_admin_identify;
> +	c.identify.cns =3D NVME_ID_CNS_CS_CTRL;
> +	c.identify.csi =3D NVME_CSI_NVM;
> +
> +	ret =3D nvme_submit_sync_cmd(ctrl->admin_q, &c, id, sizeof(*id));
> +	if (ret)
> +		goto free_data;
> +
> +	if (id->dmrl)
> +		ctrl->max_discard_segments =3D id->dmrl;
> +	if (id->dmrsl)
> +		ctrl->max_discard_sectors =3D le32_to_cpu(id->dmrsl);

Since DMRSL is in terms of LBAs, should this use nvme_lba_to_sect?

> +	if (id->wzsl)
> +		ctrl->max_zeroes_sectors =3D nvme_mps_size_to_bytes(id->wzsl);
> +
> +free_data:
> +	kfree(id);
> +	return ret;
> +}
> +
>  static int nvme_init_identify(struct nvme_ctrl *ctrl)
>  {
>  	struct nvme_id_ctrl *id;
> @@ -3238,6 +3282,10 @@ int nvme_init_ctrl_finish(struct nvme_ctrl *ctrl)
>  	if (ret)
>  		return ret;
> =20
> +	ret =3D nvme_init_non_mdts_limits(ctrl);
> +	if (ret < 0)
> +		return ret;
> +
>  	ret =3D nvme_configure_apst(ctrl);
>  	if (ret < 0)
>  		return ret;
> @@ -4768,6 +4816,7 @@ static inline void _nvme_check_size(void)
>  	BUILD_BUG_ON(sizeof(struct nvme_id_ns) !=3D NVME_IDENTIFY_DATA_SIZE);
>  	BUILD_BUG_ON(sizeof(struct nvme_id_ns_zns) !=3D NVME_IDENTIFY_DATA_SIZE=
);
>  	BUILD_BUG_ON(sizeof(struct nvme_id_ctrl_zns) !=3D NVME_IDENTIFY_DATA_SI=
ZE);
> +	BUILD_BUG_ON(sizeof(struct nvme_id_ctrl_nvm) !=3D NVME_IDENTIFY_DATA_SI=
ZE);
>  	BUILD_BUG_ON(sizeof(struct nvme_lba_range_type) !=3D 64);
>  	BUILD_BUG_ON(sizeof(struct nvme_smart_log) !=3D 512);
>  	BUILD_BUG_ON(sizeof(struct nvme_dbbuf) !=3D 64);
> diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
> index 76de7ed55d90..cf63ab07be4c 100644
> --- a/drivers/nvme/host/nvme.h
> +++ b/drivers/nvme/host/nvme.h
> @@ -276,6 +276,9 @@ struct nvme_ctrl {
>  	u32 max_hw_sectors;
>  	u32 max_segments;
>  	u32 max_integrity_segments;
> +	u32 max_discard_sectors;
> +	u32 max_discard_segments;
> +	u32 max_zeroes_sectors;
>  #ifdef CONFIG_BLK_DEV_ZONED
>  	u32 max_zone_append;
>  #endif
> diff --git a/include/linux/nvme.h b/include/linux/nvme.h
> index b08787cd0881..edcbd60b88b9 100644
> --- a/include/linux/nvme.h
> +++ b/include/linux/nvme.h
> @@ -405,6 +405,16 @@ struct nvme_id_ctrl_zns {
>  	__u8	rsvd1[4095];
>  };
> =20
> +struct nvme_id_ctrl_nvm {
> +	__u8	vsl;
> +	__u8	wzsl;
> +	__u8	wusl;
> +	__u8	dmrl;
> +	__le32	dmrsl;
> +	__le64	dmsl;
> +	__u8	rsvd16[4080];
> +};
> +
>  enum {
>  	NVME_ID_CNS_NS			=3D 0x00,
>  	NVME_ID_CNS_CTRL		=3D 0x01,
> --=20
> 2.25.4
>=20
>=20
> _______________________________________________
> Linux-nvme mailing list
> Linux-nvme@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-nvme

--=20
One of us - No more doubt, silence or taboo about mental illness.

--eXW5yKn+oC3g21lR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEUigzqnXi3OaiR2bATeGvMW1PDekFAmBJr9oACgkQTeGvMW1P
DemrOggAhKpGrhSTGpdzwQoUHZKhekLLPAMBz+5uuXfDfYZvPqvWFVbSmh4PblXC
9Bay+vMpcokX3VCTegRXkocRTsfCRvrbYWA6WUUtgv0Cid53sZodYDgNOzbGYP9M
m8VhKwx8BeI/CiH7L28TOVowIAtjr5DPh0YbsksGu0DoQkGwd7377z1qtViNxP32
ByGzswLsk2BV3jhfcipu1WMGgTm8oMcF7awxYP2vdHU5DYo8xoNFNtOXetpPELv4
Z1ADu2PEN0wmU6tHvaiozJSbi/SPStvjMG4jKWqFNOZSZ9U9KDPVHx54IWcc8VTo
5SHFm3LoQkho4EjfxYrsteIxAEb5Yg==
=smGW
-----END PGP SIGNATURE-----

--eXW5yKn+oC3g21lR--


--===============4655385975750997871==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

--===============4655385975750997871==--

