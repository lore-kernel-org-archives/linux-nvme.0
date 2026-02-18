Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71BC2E9A03B
	for <linux-nvme@archiver.kernel.org>; Wed, 18 Feb 2026 12:04:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=Qq0p+3w4wX6G1TnAwsHsyOmDKYhlDdTz6j3RJXsGNoQ=; b=pf8i9BjnBjX9vpGdjMJOf3dJ3R
	uKh3WhnK3uXYJs7kPkSPjvJ3oDdD1ztQVJZiM4boaoo86sDcAhZT0J0UL0eZwkmhOoNIkOdJ3a+1a
	qNRK9ysQ2SRJSufQdJ7/zzffoU2cvOp6wueUZWZFYPlTQjAYL16R5YUKVdcx7zXVTqdUHFeI4y+vy
	/si6UuYXzUSBR8TSSHCwDtj+lk+Snnk5Cabtd/5HYZN8xHLwGsDTe3X2ZBsYJLnDsG/BYJUFJ5sO2
	zXkPrwwPifxWTVifpXPZGspwOgeWv+aFjiDs3HZcuOScqnrL7iWAoW/vAd9qEzrb1PtwhaDRUEqtd
	Rh4FBGpg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vsgI4-00000009kIZ-0wRD;
	Wed, 18 Feb 2026 12:04:24 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vsgI2-00000009kIR-284g
	for linux-nvme@lists.infradead.org;
	Wed, 18 Feb 2026 12:04:22 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 91EAF600AE;
	Wed, 18 Feb 2026 12:04:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9456C19421;
	Wed, 18 Feb 2026 12:04:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771416261;
	bh=aNOaeCip4Eqx2Za4aq8r/E7nqPuY+YA0IjC/he0xUzI=;
	h=Date:From:To:Cc:Subject:From;
	b=Gb7JPVWofu1v+bCIRLIAPwc4Cmy4yFM/fSIVS7sxVuLtQulTcZnxgNtjiD9Rypl+J
	 BdZkiHGtxkpSmvCBVjnBXt2FKvnFCHb6FB4lybsM74+QCW74wjtCv9zCW1O5rMjvDq
	 CWBHI4xR9e4/bPzxexejZVPXQNAFVQXAWVWxdT+HzEI+ZzjkjXxHw7b2uIDoriWt61
	 O4SY4ECV8EZZhsqJ5d+psFLk+Oqfp0Z5tHgEx9/Z9wedczHWEceVOG0yNpevdFkaBt
	 n1K+7JWbRjivSccimZx2a8/3HHYzilT7p+Hz69NqSFJH1QsxUxFLKe0Xk5EP3iGwI+
	 ZAjsb1JY7nfPg==
Date: Wed, 18 Feb 2026 13:04:13 +0100
From: Joel Granados <joel.granados@kernel.org>
To: lsf-pc@lists.linux-foundation.org
Cc: linux-nvme@lists.infradead.org
Subject: [LSF/MM/BPF TOPIC] NVMe Controller Data Queue (CDQ)
Message-ID: <jrhwaqetlzkyo4gvjql2of2gohxlbrzezkyccqliyh2rybtpqb@kykxmeta5gx6>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="db4el3honyi27ead"
Content-Disposition: inline
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


--db4el3honyi27ead
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello all.

I would like to propose Controller Data Queue and how it fits into the NVMe
driver.

I sent out an RFC back in July [1] describing the first version of a Contro=
ller
Data Queue implementation in the kernel. Technical feedback at that point
included:
  1. CDQs are useful **only** for tracking LBAs during live migration (LM)
  2. LM needed to be in a "proper" state for CDQs to be useful in the linux
     kernel
  3. CDQs should be managed like any other queue and not through an ioctl

Since then, there have been six additional versions [2] that included things
like exploring different ways of allocating memory, interactions with IOMMU=
, use
of the tail pointer trigger and how to involve (or not) user space. I have =
been
reluctant to send out a second RFC as the implementations are still heavy o=
n the
user space side.

# Discussion

Here are some points that I think would be interesting:
1. Should there be special considerations for the fact that CDQs don't real=
ly
   have a submission queue? Specifically: How does the current NVMe queue
   implementation need to change in order to include the fact that there ar=
e no
   submissions for CDQs? Do they need to change at all?

2. Should the memory backing up the CDQ be segregated from the one used for
   "regular" queues? This is relevant as CDQs might live longer and be larg=
er
   (proportional to the device being LM'ed) than "regular" queues.

3. Live Migration is the encompassing subject and it would be interesting to
   note if we can already define requirements for the CDQ based on existing=
 LM
   POCs (if they exist) or LM implementation ideas.

This proposal came out shorter than I expected, but I believe its a good
opportunity to address the question of how LM/CDQ will look like in the
Linux Kernel.

Best Regards

Joel

[1] https://lore.kerne.org/20250714-jag-cdq-v1-0-01e027d256d5@kernel.org
[2] https://github.com/SamsungDS/linux/tree/sam-cdq-v{2,3,4,5,6,7}

--=20

Joel Granados

--db4el3honyi27ead
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEErkcJVyXmMSXOyyeQupfNUreWQU8FAmmVqrAACgkQupfNUreW
QU+pZwv9EnTc/ks+PpDfrPhFTzANm2lPnbb1ZI64am2ulASPTKbdHVUljbqGxkx1
I1zbLQa6TirQwDq/vpxseD9XmAJ+PlNjLtCDg+NY20bOfVXOA3IzbXf3OCLtzKDS
DFfyrsJaz3osLHp111dbn1Fm2p0b+ErEg39ypVnH+v/kv8NVREUmvBok+/j2fWBp
yo+iRBEZF/Qgk6QDAJmgNk16hqnu3UxYOigFAETbLCi6kkSnpIX3yOQNIIpz2nCa
SYR6WGB3nkYMqOijzvBkO79lAKVNDiB0bcTmVtIG8gZLCMGusk5pfosegzlB6TTy
U0Xv3fK79/z+HQr2BrbMvIZCiewxdlpegOiHXe6qs5e4H+t6M1rbncLJ5XYQu5me
Vq+GjlK7bW+l1sl1lVDlmcHOnue60HcWYF/VrliE6u6Q5Hb7nfBLyjCRRUwx7bbP
bb18KfZhnuQcqsAASLFvzFqHD86G/UBasIsEcXTXbetAR8XqQE/CAHRjwLUndceC
Q7L4MVov
=4Rep
-----END PGP SIGNATURE-----

--db4el3honyi27ead--

