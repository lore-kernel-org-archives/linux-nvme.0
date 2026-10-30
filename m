Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8074606A31A
	for <linux-nvme@archiver.kernel.org>; Fri, 30 Oct 2026 03:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=jxP+x27w;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=k8mPSzzT
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=gBADHpJ2cXd4+OnRXTX+3PxXzVmrHY+s04DTdAMdcB8=; b=jxP+x27waDwkS2roK0ibLTuTF1
	dOCWEAfo/sgDbZLSLy0MKbnqGR6m1xSaH7pR3F+O7uePm1CAD/E8CiQ0VZuv5ErFN03V4HUr2/ydk
	JAFovBE19viBre4z2kBM0G29doYmeXgSqbuq9UyIj5EA0wXIPld6I1mXZ3KryX5ZSGpD1/K9gmwnS
	9C5Pfs7CFXgDjTPxiC+/yegBcM4XKVIHVwwUzNRpy7C0n17HjdUNwpPHvQK45XyMK1o+UMZfPo7ec
	RVGj8h0PZkE3LOltuknVEpxLsyQqR1UwjI/RuQrBJCCAFwuLA95gTYpYyaTTp7zfsPyASCy8tywvW
	dZP3o29g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xMd0h-0000000AiOb-1jzT;
	Fri, 30 Oct 2026 03:10:31 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xMd0g-0000000AiOP-0jfb
	for linux-nvme@lists.infradead.org;
	Fri, 30 Oct 2026 03:10:30 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 261B2600C8;
	Fri, 30 Oct 2026 03:10:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8FD61F000C1;
	Fri, 30 Oct 2026 03:10:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793329828;
	bh=gBADHpJ2cXd4+OnRXTX+3PxXzVmrHY+s04DTdAMdcB8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=k8mPSzzTWflZ3RCIjUbJfmT9ajfwTOhQ9l7bO2kp2D19P80Av9oSQtUTDjPhow5j5
	 xcK1JfyltC4+D4OtrgGSMy3sKk3Vz+wpbZPwMFkBzOnJL2OIHBrteMY2WXFIw2KMC/
	 U1x0EBD9WiI/z0mpre3H7hxDCtOdVfjZwyALYq17zaJd6Ozo10sk4sM9K3fLfP9Utm
	 5CJtb8411sMr+qXON7wAnTTc28d7lQTiK+wdGqO4jY1EhbrSSEJbe2L+vntSO4i9eD
	 hwbeknxydFoV7FCsDo0HheES2A31lnz4exYUlR4awVYb6eOb69Ib6ne63aFmDjSS5p
	 sPo//982IjsqQ==
Message-ID: <sashiko-outbox-190213@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] nvme-pci: add NVME_QUIRK_NO_SECONDARY_TEMP_THRESH for
 WD SN740
To: "Robson Cassiano" <linux@robsoncassiano.software>
Cc: linux-nvme@lists.infradead.org
In-Reply-To: <WnzOhxjlW7w5jwpSIQmUzrvduOStpoX2h3FS@robsoncassiano.software>
References: <WnzOhxjlW7w5jwpSIQmUzrvduOStpoX2h3FS@robsoncassiano.software>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 30 Oct 2026 03:10:28 +0000
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Reply-To: sashiko-reviews@lists.linux.dev
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] nvme-pci: false NVME_QUIRK_NO_SECONDARY_TEMP_THRESH for WD 15b7:=
5017
--

commit 94ec2f511365e9d402dee1ccba8357982a5690c8
Author: Robson Cassiano <linux@robsoncassiano.software>

nvme-pci: add NVME_QUIRK_NO_SECONDARY_TEMP_THRESH for WD SN740

This commit adds NVME_QUIRK_NO_SECONDARY_TEMP_THRESH for Sandisk/WD NVMe
controllers with PCI ID 15b7:5017 so that secondary temperature threshold
sysfs attributes are hidden when the controller reports 0 and 0xffff Kelvin.

> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index 77317e5d00f9f..4f1f10bc13818 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -4170,6 +4170,8 @@ static const struct pci_device_id nvme_id_table[] =
=3D {
>  	{ PCI_DEVICE(0x15b7, 0x5009),   /* Sandisk SN550 */
>  		.driver_data =3D NVME_QUIRK_BROKEN_MSI |
>  				NVME_QUIRK_NO_DEEPEST_PS },
> +	{ PCI_DEVICE(0x15b7, 0x5017),   /* Sandisk SN560/SN740/SN770/SN5000 */
> +		.driver_data =3D NVME_QUIRK_NO_SECONDARY_TEMP_THRESH, },

[Severity: Medium]
Does setting NVME_QUIRK_NO_SECONDARY_TEMP_THRESH in nvme_id_table cause a
regression by hiding valid, host-writable temp2_min, temp2_max, temp3_min,
and temp3_max attributes on Sandisk SN560, SN740, SN770, and SN5000 drives?

Per the NVM Express Base Specification (Feature Identifier 04h, Temperature
Threshold), 0000h Kelvin (-273.15 C) is the mandatory power-on default for
the Under Temperature Threshold on all implemented sensors, and FFFFh Kelvin
(65261.85 C) is the mandatory power-on default for the Over Temperature
Threshold on all non-composite temperature sensors (TMPSEL > 0, since WCTEMP
in Identify Controller only applies to the Composite Temperature). When
commit 52deba0f02a98c ("nvme: hwmon: provide temperature min and max values
for each sensor") added secondary sensor threshold support, it explicitly
documented low =3D -273.1 C, high =3D +65261.8 C as the expected unconfigur=
ed
default output.

In drivers/nvme/host/hwmon.c:nvme_hwmon_is_visible(), secondary threshold
attributes are exposed as writable (0644) when this quirk is not set:

drivers/nvme/host/hwmon.c:nvme_hwmon_is_visible() {
	...
	case hwmon_temp_max:
	case hwmon_temp_min:
		if ((!channel && data->ctrl->wctemp) ||
		    (channel && data->log->temp_sensor[channel - 1] &&
		     !(data->ctrl->quirks &
		       NVME_QUIRK_NO_SECONDARY_TEMP_THRESH))) {
			if (data->ctrl->quirks &
			    NVME_QUIRK_NO_TEMP_THRESH_CHANGE)
				return 0444;
			return 0644;
		}
		break;
	...
}

This allows userspace to configure the secondary sensor thresholds via
nvme_hwmon_write() -> nvme_set_temp_thresh().

NVME_QUIRK_NO_SECONDARY_TEMP_THRESH (introduced in commit bd375feeaf3408 and
used in commit 340f4fc5508c29) is intended for broken controllers that fail
NVME_FEAT_TEMP_THRESH commands on secondary sensors with an error (-EIO /
Invalid Field in Command). Applying this quirk to a spec-compliant
controller simply because its unconfigured power-on defaults are 0 and
0xffff Kelvin prevents userspace from reading or configuring secondary
temperature thresholds on all 15b7:5017 devices and conflicts with
Documentation/nvme/feature-and-quirk-policy.rst.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/WnzOhxjlW7w5jwpSIQm=
UzrvduOStpoX2h3FS@robsoncassiano.software?part=3D1

