Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EAEDC25B4F
	for <linux-nvme@archiver.kernel.org>; Tue,  7 May 2024 15:02:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=MZgTnHDEEJwGlnAGUWLdaqVd2Gf47yb2MJOHuWhnFMk=; b=vf3odI1L+8yj5NNzpE6KUKZNoL
	ssh3VqxPir7b9cgx1sMxkJNYkSO1Vdn9NGcJl8GHjFQpbLiE3SRFgEyYs/yVUCoItezlyFovTnIGM
	WvoSCeyi+Osyf+pYBQZegibuUbqnTil/KyxkKS4mbBciWNO5w1rOhfXLUyPzA+OUsQ/JJarWZSlNE
	wNktAO0d1DPC/pS2zZni/X1vOXQ4hD5dUDqWwDGVklsB6VyEPFOngzp9ciKaSN4yTcbE5co4tE2RD
	//KlgQ8+y4Bmfzwv+QNRjHHaeU5K5eu3PZF+ML6fyHH6ki2jhZTwa+rG29oxDky7442PD5WPpdfue
	IhXUiAOQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s4MKu-0000000BdqX-3s1u;
	Tue, 07 May 2024 15:02:32 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s4MKr-0000000BdpD-2ifi
	for linux-nvme@lists.infradead.org;
	Tue, 07 May 2024 15:02:31 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 91B98617D8;
	Tue,  7 May 2024 15:02:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1507C4AF63;
	Tue,  7 May 2024 15:02:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715094148;
	bh=zIcctlJSswyozLgHChlkNwD9j4rqFeKzpEufaCdEVtQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UrhXLieUNepQpYogjZlPhto2t9HBrXavYCPFuGA7bxN9xV/7YgSgacq9o1C1g2cC6
	 fPrVifFA0td7heUw2oh9EKO3dU9fUJFxWFJ5lU4ACYBN8CfgF85s7dIGiAosw1ZuK8
	 BjyV0Oq4ZPNxSDLvB3F1cysctXfvo94UevvAETFfY0Ybx0jKkuzM8Y8tkyZ8DC0bYT
	 vlklPFuBuAOELj9xLsz/YIWUMNu0qN63aKzEDIiH8axDlxzrBAM74hlK4sG6VxOqbY
	 2Lax3H/o2zk2ZSRuZRcj3w2SVqTmEAslAabYfgatXh2W8aBXDrKDIXvArIJA02FJ6R
	 erWss+i22rhxQ==
Date: Tue, 7 May 2024 09:02:26 -0600
From: Keith Busch <kbusch@kernel.org>
To: Maurizio Lombardi <mlombard@redhat.com>
Cc: sagi@grimberg.me, hare@suse.de, dwagner@suse.de,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH] nvmet-auth: return the error code to the
 nvmet_auth_ctrl_hash() callers
Message-ID: <ZjpCgnYGMy7cSSR1@kbusch-mbp.dhcp.thefacebook.com>
References: <20240412134154.565298-1-mlombard@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240412134154.565298-1-mlombard@redhat.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240507_080229_765289_CF3F4E70 
X-CRM114-Status: UNSURE (   7.02  )
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

On Fri, Apr 12, 2024 at 03:41:54PM +0200, Maurizio Lombardi wrote:
> If nvmet_auth_ctrl_hash() fails, return the error code to its callers
> 
> Signed-off-by: Maurizio Lombardi <mlombard@redhat.com>

Thanks, applied to nvme-6.9.

