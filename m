Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28F28606A329
	for <linux-nvme@archiver.kernel.org>; Sun, 15 Nov 2026 19:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=4+Iq3qc9;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=T8X2StGh
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Date:Cc:To:From:Subject:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=XgpkxvsJVh8BJS3GLG5yN1xAKQOXcg9vlC9AO3bmWD0=; b=4+Iq3qc9JJOJ25
	OaFm7+yIZCHq8HROsMP+tFxGdW1eMWlvQKrsmfand+wFf4h7qYssXL0wuKDYzTYqLZumUhqBknzdE
	wkgmet6Wk/7IZxCttcaAuuyth+RYME7wSjbu9y+/fSNpQGqJ3L5x7fTg9cs7LYOWGht04nAr0QLD1
	6gkr9nppDHHbTDHBYON5paoG4bebBt5nqlA3pm+/ZV1UGhIglIu/mgAHIj4ls/RD+c6vOP3B9o0H8
	DzZdO3+DA2LrYCP7e19YzRF8nrzjSk5mXDtEPcXUGABblV8NQ14PDlMIbirWPBd1FFtpfKTwvcXYL
	i+vyXPPwbKonsbcWzdgg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xSgFZ-00000000Olk-11Cr;
	Sun, 15 Nov 2026 19:50:53 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xSgFW-00000000OlN-3BI2
	for linux-nvme@lists.infradead.org;
	Sun, 15 Nov 2026 19:50:52 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1794772248;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XgpkxvsJVh8BJS3GLG5yN1xAKQOXcg9vlC9AO3bmWD0=;
	b=T8X2StGhkNKX1VLeaUOUSBJIoqiZYnhYmtwWnCn+aiQwaBqKqmK1BGjQ3MDOcC4EDpDT5Z
	+HrTnDxHHKrBY9NP20EKWqDtuKGv25yr88dyL/vdSn1b4c1JzD/iLeKcATxBW9jR3Z1FxJ
	XvbyJkQZeDlObHYTWDz4LXprfvkCUYM=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-110-D9KHOkmNM02h1VUzRI_URQ-1; Sun, 15 Nov 2026 14:50:46 -0500
X-MC-Unique: D9KHOkmNM02h1VUzRI_URQ-1
X-Mimecast-MFC-AGG-ID: D9KHOkmNM02h1VUzRI_URQ_1794772246
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-55c16eb248eso35088281cf.2
        for <linux-nvme@lists.infradead.org>; Sun, 15 Nov 2026 11:50:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794772246; x=1795377046;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XgpkxvsJVh8BJS3GLG5yN1xAKQOXcg9vlC9AO3bmWD0=;
        b=MzlKBfmU9vaPTLSVVi1CpRj/ODeE14mExDwsjl4xQvox61+2aMaiVnpxJdj+/8TqTo
         JaCiFFTX3zlNNlZlXaoU9W8XVDsQ3n3e2X5pfQQZvXQFhBvgY8VmLIMlVXrb2znVbs6e
         q57EIwVBJgs2OawrjIowSAB/LOhdWxh7wY7THvg0k1+hSEtE28vXq1JoUAAJn3HbwQH7
         uFGG3HgYreSYaoSBC0VO6cB9z+3wbFRoV/ysjvLWbAGAjerpyjdqa87nCr4KAvkoYt41
         /QzStOmdXKbAbkYKoa5lc0sF9v8uPcZp1A8xgCuirVwNWtIVuHXIhEwgupZGU0heeT7K
         P2xA==
X-Forwarded-Encrypted: i=1; AL+hErFYfKbiPxZWmojJACe/WGOkKrbvUmr889fR4p0xeUgIUnlYzxMZEpxqk5lW1vEjQQqlbNmkOUfeAJYQ@lists.infradead.org
X-Gm-Message-State: APuU4Z8vG8uI6PxIJAqkdrv9vUb1Vcvusl4EuS+7ZiUTEHIPR11sZtB9
	aNmkzgsF/139DOtnMJaFSzSDy5dZE6iau2ycCsTvtuGk+OtWi9pJNzhaLZdFePkCezuVDSCeeir
	VO2i9pYfnWbpmN3V4u0N/48jRQpXkPo8OT9Zp4EfYXBNfA1MRM6iYQ8wS5wVXQSAJUlbk
X-Gm-Gg: AYBFou1vFKCYlPinOFLPQwgUROPs/f3doX4LqL2ERYTXvJzO+ldiRJhTUutANl3hAeh
	QToV4t09uKOEACp4Yj07+Wn/bHeTitT8tIyna/c3fasIO9lVdUsf6F3wbftbVSv6kapvS/fdfGJ
	I0GD6GVPR2t2VfpSMcQpy0WlnOCEHv95/QJ6NtMtVwG3k5as18EGc09FrObvAKY9EqHeG5ph5sZ
	3pVanYvyysE+wEOw0D2DQywsnBl2pzbxYWepwwVV/kjVtidoxcDwWl/iF2XdPx2Wfi5tgjVzQMW
	tggdPAZm8OIGWc/xPmjhu8nKHVQzxMVrDXVwa3voax7eU5ur+oTIi7iqeQyCZe9dUX9zrP4rIBa
	fmCAoV0yxuUV9hxoaSTgW2vSr5mxZItRFb0NYarGxCpjf3sUzhps6EzoU/GJl4Lo7KQ6ef8zQRG
	aOEBMcpPCGGxqoG+OwhCXCH9phVt1Ep5Rf06fYPFLkeyoDz+keX5NWOGYhjFI/nMEuT6jFEw==
X-Received: by 2002:ac8:5a0f:0:b0:533:2ef6:d98a with SMTP id d75a77b69052e-55ac7b5ad89mr149141061cf.29.1794772245954;
        Sun, 15 Nov 2026 11:50:45 -0800 (PST)
X-Received: by 2002:ac8:5a0f:0:b0:533:2ef6:d98a with SMTP id d75a77b69052e-55ac7b5ad89mr149140871cf.29.1794772245494;
        Sun, 15 Nov 2026 11:50:45 -0800 (PST)
Received: from loberman-thinkpadp1gen5.rmtusma.csb ([2600:6c65:2440:d8c:929c:b769:6def:faa3])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-55c3b7a4adbsm42557101cf.19.2026.11.15.11.50.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Nov 2026 11:50:44 -0800 (PST)
Message-ID: <fdda7a0e1caab6dda5177bdcf2ccaed4f4f63a24.camel@redhat.com>
Subject: Re: [PATCH v9 00/29] Native SCSI Multipath support
From: Laurence Oberman <loberman@redhat.com>
To: John Garry <john.garry@linux.dev>,
 james.bottomley@hansenpartnership.com, 	mkp@kernel.org
Cc: hare@suse.com, linux-nvme@lists.infradead.org,
 linux-scsi@vger.kernel.org, 	snitzer@kernel.org, jmeneghi@redhat.com,
 bmarzins@redhat.com, 	dm-devel@lists.linux.dev, hch@lst.de,
 michael.christie@oracle.com
Date: Sun, 15 Nov 2026 14:50:43 -0500
In-Reply-To: <01eac6bf-8df7-4e7a-8cc6-93e013750bce@linux.dev>
References: <20261108204733.557995-1-john.garry@linux.dev>
	 <9b90edc29d5b3be49f5bd0e0ecec5f1701e089bf.camel@redhat.com>
	 <01eac6bf-8df7-4e7a-8cc6-93e013750bce@linux.dev>
User-Agent: Evolution 3.60.2 (3.60.2-3.fc44)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 9q_g9CxAjj2mQ0Fe5tQDE2jqj7-URpWavHTdZ48UG18_1794772246
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261115_115050_896273_C68F0E8B 
X-CRM114-Status: GOOD (  29.66  )
X-Spam-Score: -2.8 (--)
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Sun, 2026-11-15 at 18:59 +0000, John Garry wrote:
> On 11/9/26 20:19, Laurence Oberman wrote:
> > 2. ANO paths are ranked the same as AO paths
> >=20
> > With the ALUA state corrected (by writing "activate" to dh_state,
> > or
> > with the fix above), I/O still went to active/non-optimized paths.
> > scsi_multipath_sdev_init() sets mpath_device->access_state to
> > MPATH_STATE_OPTIMIZED and nothing updates it, while
> > __mpath_find_path(), mpath_round_robin_path() and
> > mpath_queue_depth_path() rank paths by that field. Only
> > scsi_mpath_is_optimized()/is_disabled() read sdev->access_state.
> >=20
> > With numa, the first path in dev_list wins for every node, and
> > dev_list order follows sd probe completion, so for about a third of
> > the LUNs the current path was an ANO path. Example, LUN sdn, reads
> > completed per path for a 2000 x 1M O_DIRECT dd (:0/:3 AO, :1/:2 ANO
> > at the time):
> >=20
> > =C2=A0=C2=A0 sdn:0 0sdn:1 2000sdn:2 0sdn:3 0
> >=20
> > Every read went through the non-owning controller. From the code,
> > for
> > these LUNs the numa recheck of is_optimized() fails on every I/O
> > and
> > __mpath_find_path() picks the same ANO path again.
> >=20
> > With the change below (a template callback so the selectors use the
> > live state), plus the scsi_dh_alua fix, all 30 LUNs pick an AO
> > current path at boot, and on LUN sdl (:0/:2 AO, :1/:3 ANO):
> >=20
> > =C2=A0=C2=A0 numa=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 2000=
=C2=A0=C2=A0=C2=A0=C2=A0 0=C2=A0=C2=A0=C2=A0=C2=A0 0=C2=A0=C2=A0=C2=A0=C2=
=A0 0
> > =C2=A0=C2=A0 round-robin=C2=A0 1000=C2=A0=C2=A0=C2=A0=C2=A0 0=C2=A0 100=
0=C2=A0=C2=A0=C2=A0=C2=A0 0
> > =C2=A0=C2=A0 queue-depth 18039=C2=A0=C2=A0=C2=A0=C2=A0 0 13961=C2=A0=C2=
=A0=C2=A0=C2=A0 0=C2=A0=C2=A0 (8 parallel dd, 64k)
> >=20
> > No I/O reached the ANO paths under any policy. This is a test patch
> > to
> > show the problem, not a polished change - feel free to fold it in
> > or
> > do it differently.
>=20
>=20
> JFYI, the work which I did for ALUA support a while ago is here:
> #
> https://github.com/johnpgarry/linux/commits/scsi-multipath-v7.3-v7-alu
> a/
>=20
> I don't think that I shared this previously.
>=20
> I do notice that it would conflict with your work to do some=20
> centralising of the ALUA RTPG support.
>=20
> About the NUMA iopolicy - apart from issues in this series with not=20
> checking optimised/access_state properly - it does seem less than=20
> optimal to we only favour one device per NUMA node (when all in same=20
> optimized + enabled state). NVMe multipath support does the same. I=20
> suppose that this iopolicy relies on us having one device/path per
> NUMA=20
> node.
>=20
> Thanks,
> John
>=20
Hi John,

Thanks for the pointer, I had a look. Keeping mpath_device.access_state
in sync from the RTPG result in scsi_mpath_update_access_state() is a
cleaner way to address the ranking problem I reported, so I'm fine to
go with your approach and drop my test patch.

> I do notice that it would conflict with your work to do some
> centralising of the ALUA RTPG support.

Understood. My scsi_dh_alua patch is only the handler_data ordering
fix in alua_bus_attach(), so I'm happy to rebase or rework it on top of
your core ALUA changes if that helps.

When you have the ALUA support rebased onto v9 or v10, I'm happy to
test it on the P2000 G3 setup (dual controller, 30 LUNs, 4 paths each)
and confirm the AO/ANO path selection.

> About the NUMA iopolicy - apart from issues in this series with not
> checking optimised/access_state properly - it does seem less than
> optimal to we only favour one device per NUMA node (when all in same
> optimized + enabled state). NVMe multipath support does the same. I
> suppose that this iopolicy relies on us having one device/path per
> NUMA node.

Agreed. On FC/iSCSI hosts it's common to have several AO paths per LUN
at the same NUMA distance (all paths here report numa_nodes=3D0-1), so
round-robin or queue-depth may be the better default for SCSI. Your
call.

Thanks,
Laurence


