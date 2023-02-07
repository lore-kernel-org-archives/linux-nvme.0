Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 939F4C636CC
	for <linux-nvme@archiver.kernel.org>; Tue,  7 Feb 2023 21:20:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=IjbVWkrCarMRDdRZRab+3Uked9NJoLz7zptjpE2ztOk=; b=2TWxItO+jPm3uh2Yln8VNrFxEc
	TY3Q9kklVHQeS/DOBP7mo/go/2m6CUsLOSTf/QOMipJvgwlddgB9F3/oH80sR8YUVhLvVcavYnIho
	tOc38c08SpajRYAr9bvHPjZcguNKTVQNb9KQUDrnsrNfNkfaPLn+qemYNoRnacJttsZGupcgecofC
	U9traY6k84W0LGvmiaEIAz7kGTcN8+Aeyt5LF36iVxKc3hz++SpzHsc7M7dbVuiZTBH9qJ5MLMtwD
	LuWX2Z22FYn7Vz6fE/SttYpcgEJ1uG+FejNp2PP583fZ33Z3+2Tpa0m8yB/JoRaDkdSNxUQO8d+qP
	9fiixvSA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pPVNq-00DU0a-1D; Tue, 07 Feb 2023 21:20:10 +0000
Received: from mail-lj1-x22e.google.com ([2a00:1450:4864:20::22e])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pPVNn-00DU01-Vq
	for linux-nvme@lists.infradead.org; Tue, 07 Feb 2023 21:20:09 +0000
Received: by mail-lj1-x22e.google.com with SMTP id b16so9309415ljr.11
        for <linux-nvme@lists.infradead.org>; Tue, 07 Feb 2023 13:20:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pcpartpicker.com; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=IjbVWkrCarMRDdRZRab+3Uked9NJoLz7zptjpE2ztOk=;
        b=VRDgJV//6NHEcGGlGWleUeUo/l80W9qorcLchygW0XhIra/2HLxqVTqDEYS//mPJmt
         bjQXY9kmpio0mmoFb5Geo3zCQgmKn5lW6pFHYmmBpyd5luKC05br3hDj1biLotF8HY0T
         HG+wKGZv1REPobyQ/0JH35GW8yGuVFtW7BTIAyljNchwFP54ia+uMSPFil5QA4iR1gPW
         S4CbUZZeR1CrSomorF9dzPOz5vzWsogcOzZkaPhom/b56lUrR3rUd9RscmWyuMT5Ton9
         kK60+0qrLr0GiYHo+FEjlk/81G019WOM90M4FnvPOhV3gdW23YG2GfGdb7uGVlhvdxkl
         lNxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IjbVWkrCarMRDdRZRab+3Uked9NJoLz7zptjpE2ztOk=;
        b=eFDYSq72DcwDlXQF3Gd6TbBm9smgdZnK73oK52OsrGTXn9upgOPxSE+GevKlnV4xbX
         u2Ou8VIK4RvU+In1I2D9cY7P8w+BVmucYP/VdxC1S2fqZwczSKAsMa9HQsJkuE3Z9fSq
         Hss7de4rJM3tpc8NMO/hKXRvz90+l/MMsv34l8r+Q5wkKMz+HlmF5eN+SegczwU52Zwb
         aL1BtwCzl0FUBdqPSuQbIHPiDzrWyMLP+isjrTdsH6R6fYSapgFdycn5SVooJ+Syy6VS
         n79cG4ueS180UveO3FbHjFOSzBROHvK9cQpG/Nro6TEnRwq/jsTllrTw8Hz+mr0AJn6l
         MwVA==
X-Gm-Message-State: AO0yUKVRSqKxD/e/YJazHmCbYcVt1LENj8ONAyKoMVk8GSDn6IogANaf
	u/GQ9A2Pai4vue7OV5Uhjg3oTqJDW3P5u4NWCH45FB8St3zOUZCy
X-Google-Smtp-Source: AK7set/CQcR9stzLZ6hJn1lFoKANUPs5Z2sPc3wkolhGy53FIR14IeoeS1g+8Sm+4x9kExUa+9PZMv4vF8/t+EjQr2g=
X-Received: by 2002:a2e:9d18:0:b0:28b:9115:1fe1 with SMTP id
 t24-20020a2e9d18000000b0028b91151fe1mr875995lji.35.1675804366076; Tue, 07 Feb
 2023 13:12:46 -0800 (PST)
MIME-Version: 1.0
References: <CADqNVToVWkJHSPbYqJRgnFjdMt3N_-UkCHZtHVTRhpGNThX3Wg@mail.gmail.com>
 <20230130094727.vngui7phl3cltb7j@carbon.lan>
In-Reply-To: <20230130094727.vngui7phl3cltb7j@carbon.lan>
From: Nick Neumann <nick@pcpartpicker.com>
Date: Tue, 7 Feb 2023 15:12:33 -0600
Message-ID: <CADqNVTqTYrvtnzn4jSq4Qeserg1fRY7WPMOLmqhuTSBkMrVZVA@mail.gmail.com>
Subject: Re: Option to never do BLKRRPART ioctl in nvme format?
To: Daniel Wagner <dwagner@suse.de>
Cc: linux-nvme@lists.infradead.org, Keith Busch <kbusch@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230207_132008_057564_3215CC18 
X-CRM114-Status: GOOD (  19.40  )
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

On Mon, Jan 30, 2023 at 3:47 AM Daniel Wagner <dwagner@suse.de> wrote:
> I can't really say why BLKRRPART was added initially. The comment which was
> added later on
>
> /*
>  * If block size has been changed by the format
>  * command up there, we should notify it to
>  * kernel blkdev to update its own block size
>  * to the given one because blkdev will not
>  * update by itself without re-opening fd.
>  */
>
> indicates we don't need BLKRRPART necessary. I would like to understand first
> what's going on before dropping BLKRRPART.
>
> @Keith, do you happen to remember what's the reason for BLKRRPART?

Thanks much for the response. In my more meandering original email
(before I composed this one), Keith had said:
> There really is no need for user space to do the BLKRRPART ioctl
> anymore. The kernel takes care of the rescan automatically, so unless
> you've a really old kernel, we might be better off just removing the
> ioctl."

I had added a sleep delay of a few seconds as a workaround for the
intermittent error from BLKRRPART ioctl. It worked great, until today.
After hundreds of formats without issue, I got "failed to re-read
partition table" once again. So I'll resort to allowing the error code
if the error message is precisely that, and hopefully it can be
removed from nvme format sometime soon. :-)

