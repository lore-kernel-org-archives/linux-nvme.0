Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F5B3606A321
	for <linux-nvme@archiver.kernel.org>; Mon,  9 Nov 2026 21:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=SalLMhfO;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ivsia7vp
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=VMD+l5bqsg8E22bV6wHCiw2PxfRnLcTjHQDV7H1gBPY=; b=SalLMhfOfDM2VfU3WTtQ+01le2
	S4wbpW5OBl4CqRmuu8pTj1pj9TDgo6vnCCMIN8VajDIPEZCPh/0V+XfI3eQ5bfyK04W5EhLfWglPY
	HSE2KCSR9X/150U4RCrXYJaWWEhRj1/Zdlja8HJMMGyuraiJagXlLxdzolwdGDkZTKhL5iH2+RYvP
	fYGqqHFPnR6i2AN2xC9CAPzMtfgpSwW4QE+CIc6guYUNmUbbx7B6yVfjafhLRmSf/WakgnV+cdspQ
	5qgbhk19khxfhp1CK8R4q80sfOuzUf38yD5YEhfm49vA1hkOok48VsD/7MC6QjAvUpNmr76Losdcm
	c5apAqIw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQXMr-00000001pFQ-0Ltj;
	Mon, 09 Nov 2026 21:57:33 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQXMp-00000001pEc-1WLS
	for linux-nvme@lists.infradead.org;
	Mon, 09 Nov 2026 21:57:32 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 813B061C68;
	Mon,  9 Nov 2026 21:57:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13C991F008A3;
	Mon,  9 Nov 2026 21:57:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794261450;
	bh=VMD+l5bqsg8E22bV6wHCiw2PxfRnLcTjHQDV7H1gBPY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ivsia7vpxG/PqWN5Z9OIuolAaWFjCdxzJFqu7EZS48sYXMQp54yXHD1JqRiDLiCp5
	 cGtiLBJD59h7VEZZl8q2heyWIXpEetDBV4Qp4sHRD1vLTTRobV/qi2rgPNMeDBsu9C
	 mQf5bOR10o2FhlqMFSfq7dPoDPUdHwKNBEL0hLxtanStDRmALSmicC3aDGnZx7HB49
	 LEvtQ+t5Bz73ELBw9NWCLSGM8ahrMvjj1vG8AZ22OMFiUax4Oo+b9sa+AQhu95Ubg8
	 VS/S5Bm0Hmc0xyWywKKddlzJL1a2jbGVrLRXM/4+HohDwPUNwUp1Ttr5KQi4C+LO4b
	 F3kh9vxPHonng==
Message-ID: <sashiko-outbox-205697@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 18/23] nvmet: fix nvmet_ns::device_path access using
 nvmet_subsys::lock
To: "Nilay Shroff" <nilay@linux.ibm.com>
Cc: linux-nvme@lists.infradead.org
In-Reply-To: <20261109033102.982191-43-nilay@linux.ibm.com>
References: <20261109033102.982191-25-nilay@linux.ibm.com>
 <20261109033102.982191-43-nilay@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 09 Nov 2026 21:57:29 +0000
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

Thank you for your contribution! Sashiko AI review found no new issues
in this patch, but noticed 1 related pre-existing issue it does not
introduce:
- [Critical] nvmet: use-after-free in nvmet_req_find_ns() [1]
--

commit a468df0df47780f4511f3eba5f46e2ca65355d7b
Author: Nilay Shroff <nilay@linux.ibm.com>

nvmet: fix nvmet_ns::device_path access using nvmet_subsys::lock

This commit acquires subsys->lock in nvmet_ns_device_path_show() and moves
kfree(ns->device_path) under subsys->lock in nvmet_ns_free() to satisfy
Clang thread-safety analysis for nvmet_ns::device_path.

> diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
> index 805b5f70eb066..6b11beb2e2b20 100644
> --- a/drivers/nvme/target/core.c
> +++ b/drivers/nvme/target/core.c
> @@ -730,13 +730,13 @@ void nvmet_ns_free(struct nvmet_ns *ns)
>  		subsys->max_nsid =3D nvmet_max_nsid(subsys);
> =20
>  	subsys->nr_namespaces--;
> +	kfree(ns->device_path);
>  	mutex_unlock(&subsys->lock);
> =20
>  	down_write(&nvmet_ana_sem);
>  	nvmet_ana_group_enabled[ns->anagrpid]--;
>  	up_write(&nvmet_ana_sem);
> =20
> -	kfree(ns->device_path);
>  	kfree(ns);
>  }

[Severity: Critical]
This problem wasn't introduced by this patch, but can freeing ns immediately
after xa_erase() in nvmet_ns_free() cause a use-after-free in
nvmet_req_find_ns() [1]?

nvmet_ns_disable() waits for the RCU grace period (via percpu_ref_kill())
while ns is still published in subsys->namespaces.  nvmet_ns_free() then
erases the XArray entry and synchronously calls kfree(ns) without waiting
for another RCU grace period:

CPU0                                    CPU1
nvmet_ns_free()
  nvmet_ns_disable()
    clear_bit(NVMET_NS_IO_LIVE, ...)
    percpu_ref_kill(&ns->ref)
    wait_for_completion(...)
                                        nvmet_req_find_ns()
                                          rcu_read_lock()
                                          req->ns =3D xa_load(...)
  xa_erase(&subsys->namespaces, ...)
  ...
  kfree(ns)
                                          test_bit(NVMET_NS_IO_LIVE,
                                                   &req->ns->flags)
                                            <-- use-after-free

drivers/nvme/target/core.c:nvmet_req_find_ns() {
	rcu_read_lock();
	req->ns =3D xa_load(&subsys->namespaces, nsid);
	if (unlikely(!req->ns) ||
	    !test_bit(NVMET_NS_IO_LIVE, &req->ns->flags) ||
	    !percpu_ref_tryget_live_rcu(&req->ns->ref)) {
    ...
}

Because ns remains visible to xa_load() until xa_erase() runs in
nvmet_ns_free(), a reader entering nvmet_req_find_ns() after
nvmet_ns_disable() finishes (or when the namespace was never enabled) can
load req->ns just before xa_erase() and dereference it after kfree(ns).
Freeing ns with kfree_rcu() or waiting for an RCU grace period after
xa_erase() would prevent this race.

[1] https://sashiko.dev/#/bug/linux-a674b331-ed9a-4029-b6d0-2a1abec4aaf0

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261109033102.9821=
91-25-nilay@linux.ibm.com?part=3D18

