Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE53FCDB47E
	for <linux-nvme@archiver.kernel.org>; Fri, 13 Oct 2023 14:07:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Ra2aXed8uArUI7TwjFcHN89SN3CjIBH2+/864FeYqEo=; b=vq3V5XGRMpdMAOo/HxBopuxUgn
	eNUXFdKSU0MHE29LGcLypPeTS4bRrUD41UnKPdxspJpaAxPg7/3QIXiMe/x06mHeTOixrEWp0vckv
	MovQvSrb3pgGt7TI5TG7daQLkxBsi7KmjiHHfdIftXcHLiVWKETMBxOQxURhW6650ZKDb9ZjOlK86
	cmuUY70HVtFy7WjGQQ/6upYV4AAdn4Y4CDc76IbR/eA37xnjmTwZdGxB8wumiPf9lvh/ACa1ibTEd
	IKwEBkU2VChmYhl8YimgRvLoOiCzHjx/SMuHaG5zSpmGNp+VGL7KHkUqNPNluhK6JSQs2wTbwVAom
	TyBk/7kQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qrIpU-003Ytv-0E;
	Fri, 13 Oct 2023 14:07:52 +0000
Received: from ams.source.kernel.org ([2604:1380:4601:e00::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qrIpR-003Yt4-17
	for linux-nvme@lists.infradead.org;
	Fri, 13 Oct 2023 14:07:50 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by ams.source.kernel.org (Postfix) with ESMTP id 0D3C8B82AFF;
	Fri, 13 Oct 2023 14:07:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F572C433C8;
	Fri, 13 Oct 2023 14:07:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697206067;
	bh=w/mdAXQ4DIZNVExM6+HaBdT5TCkbE6ZvzTL0s1NL0EU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eTT0h/SDDSXoXOqvm4V87CtMdIqrsWe9l3sCV0TdNFc8QE/PG2bfTzBWAqNdmqdLe
	 ThjDf2biYkFOMh/2RxiANbMq8dZA6G1ZJbLWr1gVwAHmH3lcqMYYtiK0XD+rO0JtLk
	 AkJBkYar4rnpuj5HUV3AAQdZ7IZhjCCVLmSm/udfvd2PND6EjpbjXEgio8fdDTDB5w
	 39E0e6AX+hL+YeDreXFmuthXHOLR9xWHy97lDeUGgYXULbYmjJl+1ixmNfmF9mUKvI
	 9dmQ1zDw9kf4AMMcL+f5rDhJtfgM7MwdG3G8PM9XCH5itqRvH35tSdLNkifxHgRLQr
	 NX1eMCoe4mqyQ==
Date: Fri, 13 Oct 2023 08:07:45 -0600
From: Keith Busch <kbusch@kernel.org>
To: Daniel Wagner <dwagner@suse.de>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] nvme: update firmware version after commit
Message-ID: <ZSlPMcLHZywXGhdR@kbusch-mbp>
References: <20231013062623.6745-1-dwagner@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231013062623.6745-1-dwagner@suse.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231013_070749_512381_55F3EE53 
X-CRM114-Status: GOOD (  14.15  )
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

On Fri, Oct 13, 2023 at 08:26:23AM +0200, Daniel Wagner wrote:
> +static void nvme_update_firmware_rev(struct nvme_ctrl *ctrl)
> +{
> +	struct nvme_id_ctrl *id;
> +	int ret;
> +
> +	ret = nvme_identify_ctrl(ctrl, &id);
> +	if (ret) {
> +		dev_warn(ctrl->device, "Identify Controller failed (%d)\n", ret);
> +		return;
> +	}
> +	memcpy(ctrl->subsys->firmware_rev, id->fr,
> +	       sizeof(ctrl->subsys->firmware_rev));
> +}
> +
>  static void nvme_fw_act_work(struct work_struct *work)
>  {
>  	struct nvme_ctrl *ctrl = container_of(work,
> @@ -4109,6 +4123,7 @@ static void nvme_fw_act_work(struct work_struct *work)
>  	nvme_unquiesce_io_queues(ctrl);
>  	/* read FW slot information to clear the AER */
>  	nvme_get_fw_slot_info(ctrl);
> +	nvme_update_firmware_rev(ctrl);

The "fw_slot_info()" call also gets the firmware version, so no need to
do it a different way. Just add the memcpy to that function instead of
introducing a new one.

