Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13101C46CD2
	for <linux-nvme@archiver.kernel.org>; Tue, 30 Jan 2024 17:31:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9yeaACr54hGOR3PJCXEUWLooPQv2rteJL7UV3aUwT4w=; b=kBFViLUINYhan0UfEIjKhTjyVy
	GxSh5dxIkQgkmXeRi7LtjahD1F0cIXcYtxKMeTZCYM8KNIVODcgusx/cu4cRSrtnZJ5Cpx8SZj7cQ
	6sWaXzz50uy5Qld9gkim1U8/RihrDJRJMpJv1pyU/pMLzVMs2C38Hj/tIN10YCmruMp7adD1qiu77
	8xsfNwfFPTV1V2uio/mB9PXId8Xfd6Pmcjf3FSYMUTrKVRyut3DqX4R2qVQYF1BBvpR9HR4IV4H0q
	Ji3huutWNtNZ+kZLWzrupGTpuiv+LGbC7nEraXuLk+lmiuao/n/QtNl1NwnHMHdK2vC5sQZJRj0Vr
	ksp612zA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rUrxk-0000000HZgK-2MF0;
	Tue, 30 Jan 2024 17:31:56 +0000
Received: from hr2.samba.org ([2a01:4f8:192:486::2:0])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rUrxi-0000000HZfL-1Uot
	for linux-nvme@lists.infradead.org;
	Tue, 30 Jan 2024 17:31:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=samba.org;
	s=42; h=Message-ID:Cc:To:From:Date;
	bh=9yeaACr54hGOR3PJCXEUWLooPQv2rteJL7UV3aUwT4w=; b=avhlbDV4V49IzzLxko1dQ33JPH
	dM1PN9tDamY9zVq0uTHuUnpbyfAqKzag/uY5V8DTLJS0rWBzJBOt7Flio5D65om7NlVXrddoIK0/x
	sxZ12VEpTK7FjfMPdVqAvcGfw+bJf3AVmdXhyWZdZgGQECIURMdl37RTl0068tu9ejl/wuGAomkRA
	QeUBHE5dxeT39zeGkojVh9wUW5gbyi1+f8AR3g/bB9pZ18zMWaJzALdUdKDrzRzP4nKNE6wbJGSky
	DD9/HZ8GAQHjCkHsa+2mzp9LZBs28Ulf42thqLe44NtdCwaKuo4yAHUQd6c87YAoL8laOkEZD5rN6
	pzlQDArPCGErusJ0RYGsZtGueSE7WBwsgjQzBA1oQzuz8CEbw4TWQ7GfX/KiJnq2L+MVfDv1GyLPQ
	kDxScfg4BBZEuRBQavKjL7DelKdKlS6q6uaz7nwfUjuaPcxlrYlA5dyF7tsdGRpZtQfovHxdh3LA2
	Gxg//zbvkNL/SzVJhJCZxIv4;
Received: from [127.0.0.2] (localhost [127.0.0.1])
	by hr2.samba.org with esmtpsa (TLS1.3:ECDHE_SECP256R1__ECDSA_SECP256R1_SHA256__CHACHA20_POLY1305:256)
	(Exim)
	id 1rUrxY-00AdXr-07;
	Tue, 30 Jan 2024 17:31:44 +0000
Date: Tue, 30 Jan 2024 09:31:40 -0800
From: Jeremy Allison <jra@samba.org>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Jeremy Allison <jallison@ciq.com>, tansuresh@google.com, hch@lst.de,
	gregkh@linuxfoundation.org, rafael@kernel.org, bhelgaas@google.com,
	linux-nvme@lists.infradead.org, jra@samba.org
Subject: Re: [PATCH 4/5] nvme: Add a new exported function
 nvme_request_shutdown().
Message-ID: <ZbkyfB03maJLX4aD@jeremy-HP-Z840-Workstation>
References: <20240129181953.1183084-1-jallison@ciq.com>
 <20240129181953.1183084-5-jallison@ciq.com>
 <6dd1fc75-e5c0-4bde-94cb-b0509a5d8e3c@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <6dd1fc75-e5c0-4bde-94cb-b0509a5d8e3c@grimberg.me>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240130_093154_421948_1E2747A0 
X-CRM114-Status: GOOD (  10.22  )
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
Reply-To: Jeremy Allison <jra@samba.org>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Tue, Jan 30, 2024 at 12:58:31PM +0200, Sagi Grimberg wrote:
>>+	ctrl->ctrl_config &= ~NVME_CC_SHN_MASK;
>>+	ctrl->ctrl_config |= NVME_CC_SHN_NORMAL;
>>+	return ctrl->ops->reg_write32(ctrl, NVME_REG_CC, ctrl->ctrl_config);
>>+}
>>+EXPORT_SYMBOL_GPL(nvme_request_shutdown);
>
>I think the name can be better, nvme_request_shutdown makes it seem
>that you are actually sending a request to the controller.
>
>Maybe nvme_ctrl_shutdown_start ? or as I suggested before
>nvme_shutdown_nowait ?

I think the idea of adding _ctrl_ in the name is a good
one as it makes explicit the level it's operating on.

I think nvme_ctrl_shutdown_start() is the better name,
so I'll use that for the next version.

Thanks !

