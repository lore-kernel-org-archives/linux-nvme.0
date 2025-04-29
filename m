Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B454C369D5
	for <linux-nvme@archiver.kernel.org>; Tue, 29 Apr 2025 00:34:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=R/bNT3QCm+5HXii/nBKCcmEN9QkMNXX0g0Y3mbu1zXQ=; b=4/2Mz15tsshtuUahsqFIJpq8dR
	eP2gVwrRDiO39gBrQn1rOi391OtlqMHPO/TRyrIotyqe9ZTnx3AKzkvk0eMbHBB/BGh5XCYZSsFqZ
	UPQJF9V/HkztDIkCrEBlYfwV59cPvvFaafWnUWlDb7TW7FLcFVo+4nD9NOEhhpbHOqOzUYLuQ6+Mm
	Fb51uMLYBUPSzXkLnUqfHuRQgiPbNSo03hAs2b97YqVRr7RvlSZAA0UK/toXFPeN72BYtEKvDvyYC
	fhHF+QknSua0NTmVEISo5+nELanWXbtTwmaqy8LdnuWgOrHY/HunH3CUUn2psy+k2HPENpEhXJV3S
	MFduS1Xw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u9YvP-00000007u1T-3sWg;
	Tue, 29 Apr 2025 00:34:15 +0000
Received: from mail-yw1-x1136.google.com ([2607:f8b0:4864:20::1136])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u9YvK-00000007tyA-1gDL
	for linux-nvme@lists.infradead.org;
	Tue, 29 Apr 2025 00:34:15 +0000
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-6ff4faf858cso38202447b3.2
        for <linux-nvme@lists.infradead.org>; Mon, 28 Apr 2025 17:34:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745886849; x=1746491649; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R/bNT3QCm+5HXii/nBKCcmEN9QkMNXX0g0Y3mbu1zXQ=;
        b=h+MBgUQNBrjE/JjniEhvMzADqckICZrg2k3yNIrSFN9eyFepfHHf6IdBGF2eSftjdv
         nKha3OmUGKR/ahme9k7p44qI+6yr8SIKofHsSOKHnNtLTJOWyZy3xz1VE5vzh0sJlkoD
         e4M9TU4yfOE0WaQjymRobaE8qGKGb9S18SlfBVJrE8AcAMmy4muBcKn1CH6WxK7f2N24
         QMbHyHFlQvIM0DXhTv2oeRU6idpTUNkG/oq7Ua0o5PgLd4s2ri3/7iRi/qa8ENFFLfrv
         iwP4XmLauo1LMDpftmqsnJuF/TEmo4TXRDhAyFXCSUqveQdqmFK8dkKOTW/+tzXaYnE5
         hYhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745886849; x=1746491649;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R/bNT3QCm+5HXii/nBKCcmEN9QkMNXX0g0Y3mbu1zXQ=;
        b=rO9PUDlIQsAm0vZpaRkYBVRcWGaXgKBaEVqvLFdXJ5+r7RPcNXSzKMfaKXoI/yEloY
         b3fpF+Z5KgUR407jrxSOtuUGOv34c6o44J4gjSCUh+XUusmT8gu9bfhpkUzLsx1oOaA5
         vmkEkzR+tu4AuTG/83Ke7+5MHh3fI5pp9LgFf+TFaWOcDbKYAmQ2O6JJjtAQoMcs7b16
         wm6EPtMndEXKKdvcgGSTZwODgIQtU5BMI0nFAnJnM/Ho6y4Schy9LC86F6WaQG6HVsgL
         H304xQAmqvlLGsNv61WBiANK66c7L1n+SPnYcBVVY2QXL6R8pxcEdpn2vcnVi7bCNIzn
         vAkQ==
X-Forwarded-Encrypted: i=1; AJvYcCUefdayjLOoqoGjFOl6HHXZp4SVXEXvHJdyjRrJoRDhfp+f0++eA85cmmTW6dALoPWomnfbkJcDQ0Zl@lists.infradead.org
X-Gm-Message-State: AOJu0YyiWVZR/8qMGxu6qHtZqFje4uHUhisB4yODb5GPc5Cxa0x4gg5d
	gFfUPdGJoH03/e/KRMyncR6b8eYha2gBpf45rGaqshBnZ2pitpJwODJKNag7IDOOJeI+4i9Pdav
	C1dTpOHp3u0rhrnaYr7TAKpP0akk=
X-Gm-Gg: ASbGnctVibozqkxxQKjLfEO3cXXFPcLaJ7QtCcjN5a4d2th1mKxev5BjP4kNsDqqxuT
	sc0GIZi/FWJ2zZWjlJq8Dr1q4B7/O9HUAFd62fMEFL8CKqSf+P+zl+EQ82e8QPG/mmsfrER/JMf
	AokHQwYxLdUMITFIMc7RFzQOg=
X-Google-Smtp-Source: AGHT+IEGnkHnVEGFnjSW2b1OqykcPp10zCsxNzBtGjJEggdM64dVIABc4pzTRnWXg867P+9brS8y9M8I0JDjCZL4cwE=
X-Received: by 2002:a05:690c:884:b0:708:39f9:ae49 with SMTP id
 00721157ae682-70899749458mr29800717b3.29.1745886849192; Mon, 28 Apr 2025
 17:34:09 -0700 (PDT)
MIME-Version: 1.0
References: <20250428063635.125879-1-hare@kernel.org> <20250428063635.125879-2-hare@kernel.org>
In-Reply-To: <20250428063635.125879-2-hare@kernel.org>
From: Justin Tee <justintee8345@gmail.com>
Date: Mon, 28 Apr 2025 17:32:15 -0700
X-Gm-Features: ATxdqUF3SYReFA0xM-HiG6Mn95jR5Pm3r4-7_bHxZq7OoM9Kw9ffIOcnvDZl5Co
Message-ID: <CABPRKS-xkcB8mv0huFkOqC10T1Pw2io_GAvfDA2+a6z8rUSDqw@mail.gmail.com>
Subject: Re: [PATCH 1/4] fc_els: use 'union fc_tlv_desc'
To: hare@kernel.org
Cc: Justin Tee <justin.tee@broadcom.com>, James Smart <jsmart2021@gmail.com>, 
	Dick Kennedy <dick.kennedy@broadcom.com>, Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>, 
	Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250428_173410_437004_A7B08D5F 
X-CRM114-Status: UNSURE (   9.37  )
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

Hi Hannes,

May we also update lpfc=E2=80=99s function header argument=E2=80=99s descri=
ption name as well?

diff --git a/drivers/scsi/lpfc/lpfc_els.c b/drivers/scsi/lpfc/lpfc_els.c
index cf1fbfb15c5d..9abab90edc61 100644
--- a/drivers/scsi/lpfc/lpfc_els.c
+++ b/drivers/scsi/lpfc/lpfc_els.c
@@ -9938,7 +9938,7 @@ lpfc_display_fpin_wwpn(struct lpfc_hba *phba,
__be64 *wwnlist, u32 cnt)
 /**
  * lpfc_els_rcv_fpin_li - Process an FPIN Link Integrity Event.
  * @phba: Pointer to phba object.
- * @tlv:  Pointer to the Link Integrity Notification Descriptor.
+ * @li:  Pointer to the Link Integrity Notification Descriptor.
  *
  * This function processes a Link Integrity FPIN event by logging a messag=
e.
  **/
@@ -9968,7 +9968,7 @@ lpfc_els_rcv_fpin_li(struct lpfc_hba *phba,
struct fc_fn_li_desc *li)
 /**
  * lpfc_els_rcv_fpin_del - Process an FPIN Delivery Event.
  * @phba: Pointer to hba object.
- * @tlv:  Pointer to the Delivery Notification Descriptor TLV
+ * @del:  Pointer to the Delivery Notification Descriptor TLV
  *
  * This function processes a Delivery FPIN event by logging a message.
  **/
@@ -10005,7 +10005,7 @@ lpfc_els_rcv_fpin_del(struct lpfc_hba *phba,
struct fc_fn_deli_desc *del)
 /**
  * lpfc_els_rcv_fpin_peer_cgn - Process a FPIN Peer Congestion Event.
  * @phba: Pointer to hba object.
- * @tlv:  Pointer to the Peer Congestion Notification Descriptor TLV
+ * @pc:  Pointer to the Peer Congestion Notification Descriptor TLV
  *
  * This function processes a Peer Congestion FPIN event by logging a messa=
ge.
  **/
@@ -10039,7 +10039,7 @@ lpfc_els_rcv_fpin_peer_cgn(struct lpfc_hba
*phba, struct fc_fn_peer_congn_desc *
 /**
  * lpfc_els_rcv_fpin_cgn - Process an FPIN Congestion notification
  * @phba: Pointer to hba object.
- * @tlv:  Pointer to the Congestion Notification Descriptor TLV
+ * @cgn:  Pointer to the Congestion Notification Descriptor TLV
  *
  * This function processes an FPIN Congestion Notifiction.  The notificati=
on
  * could be an Alarm or Warning.  This routine feeds that data into driver=
's

Regards,
Justin

