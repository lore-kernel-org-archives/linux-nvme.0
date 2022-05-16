Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDD33C433EF
	for <linux-nvme@archiver.kernel.org>; Mon, 16 May 2022 16:16:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=ES8hxModnbFGHs8OJMv3c09O2gXQ+FAAPw/RwV8o/F0=; b=bmgom9+z8MkPIfVZGZZsHvmTMw
	/78aWISbjMtVL8Tz+8RRd2hMPsBf0nPZ7u1rI6bZFyhD5TuWqRVqyRVW6GTgt5AtClCYcOQyc49IA
	kZblFX0r26aL+7uXCSJClpK4q6VBFke5v42VE+NCJ0ROWT4YzuOduyUnAsAETXdJ5Z4FyWknBu0t+
	Et5FJmqT2BpvBmbkbhIIu2A9zPrex6Xf67SiflkuC6bufakQD6EusvsxtK5Izuu8WADHoqmxxVNJh
	hKnyFavizFQHANnL5lVGzjVHO7Ol2+GbqGwZPy2yzXNv0LAG6VCf2PK7okagg/G0lCHo/9juycxRl
	SAhAHetg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nqdOM-008vDE-B2; Mon, 16 May 2022 16:16:18 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nqdOG-008vBv-Cp
 for linux-nvme@lists.infradead.org; Mon, 16 May 2022 16:16:14 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 0207522004;
 Mon, 16 May 2022 16:16:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1652717769; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type;
 bh=ES8hxModnbFGHs8OJMv3c09O2gXQ+FAAPw/RwV8o/F0=;
 b=s25p2vbvljCTcJKdF7D8+5NzTNdAP7jDc4aO0WcTDPNiitC4xy6iM6p90dn+TeCBXN/mDm
 uvgHW6t6CR9u/UWQYrUUDTRiibe5kyA2LP9SJFZ2rJHu6ss+tSkwgz+CmI88RswfSPxiKw
 S3V44DaGOfULYIp1Q5FpODevxr98PIU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1652717769;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type;
 bh=ES8hxModnbFGHs8OJMv3c09O2gXQ+FAAPw/RwV8o/F0=;
 b=lA7JzXgXtgiFc/CR09821teiJw5M2JeBs+vKD6Uvy/G40c++Jda7RlcCC0H+Mt0eXfBhN4
 NTZq02nTFCuoYWCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E487D13AAB;
 Mon, 16 May 2022 16:16:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 9uGwN8h4gmKLSQAAMHmgww
 (envelope-from <dwagner@suse.de>); Mon, 16 May 2022 16:16:08 +0000
Date: Mon, 16 May 2022 18:16:08 +0200
From: Daniel Wagner <dwagner@suse.de>
To: linux-nvme@lists.infradead.org
Cc: Ming Lei <ming.lei@redhat.com>, Keith Busch <kbusch@kernel.org>,
 Sagi Grimberg <sagi@grimberg.me>, Hannes Reinecke <hare@suse.de>,
 Martin Wilck <martin.wilck@suse.com>,
 Belanger Martin <Martin.Belanger@dell.com>,
 James Smart <jsmart2021@gmail.com>, Hanumanthu H <hanumanthuh@micron.com>
Subject: nvme-cli license clarification
Message-ID: <20220516161608.of4tklsysuvgbtie@carbon.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220516_091612_625578_2061C520 
X-CRM114-Status: GOOD (  15.06  )
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

Hi,

The question pop up about the license of nvme-cli and libnvme. The
reporter noticed that there are some inconsistency [1]. First let's just
have a look at nvme-cli.

Keith stated that the original license is/was GPL-2.0-or-later.

Most of the files are either not having any copyright notes at the
beginning of the file or are sporting the 'or any later version'
snipped. So all good here, nothing to do.

But there are some noticeable exceptions though which all have
GPL-2.0-only. I assume the general mood is that we want the project to
be licensed as GPL-2.0-or-later, so let's try to resolve these issues:

1. fabrics.c

   Ming added this file initially with

   Copyright (C) 2016 Intel Corporation. All rights reserved.
   Copyright (c) 2016 HGST, a Western Digital Company.
   Copyright (c) 2016 Samsung Electronics Co., Ltd.

   There are plenty of contributions for this file. E.g the
   counted lines contributed by an author for the monolithic
   branch (aka the 1.x version)[2]:

    456 Sagi Grimberg
    328 Ming Lin
    253 Martin Wilck
    229 Keith Busch
    175 Hannes Reinecke
     87 Martin Belanger
     85 James Smart
     50 Minwoo Im
     47 Andy Lutomirski
     45 Johannes Thumshirn
     41 Christoph Hellwig
     39 Martin George
     26 Roland Dreier
     23 Jay Freyensee
     20 Eyal Ben David
     11 Chaitanya Kulkarni
     10 Duane Grigsby
      8 Israel Rukshin
      7 Maurizio Lombardi
      6 Max Gurtovoy
      4 Yair Elharrar
      4 Gollu Appalanaidu
      3 Yi Zhang
      3 Eric Curtin
      3 Daniel Wagner
      2 Rakesh Pandit
      2 Bart Van Assche
      1 Tomasz Zawadzki
      1 Nitzan Carmi
      1 Logan Gunthorpe
      1 Gwendal Grignou
      1 Guan Junxiong
      1 Breno Leitao

  and for the master branch (aka 2.x version)

    564 Hannes Reinecke
    350 Daniel Wagner
    127 Martin Belanger
     80 Ming Lin
     57 Sagi Grimberg
     35 Tokunori Ikegami
     24 Keith Busch
     11 Martin George
      8 Christoph Hellwig
      7 Wu Bo
      6 Roland Dreier
      5 Jay Freyensee
      3 Eyal Ben David
      2 Rakesh Pandit
      2 Martin Wilck
      2 Gollu Appalanaidu
      2 Chaitanya Kulkarni
      1 Yi Zhang
      1 Vincent Fu
      1 Tomas Bzatek
      1 Minwoo Im
      1 Logan Gunthorpe
      1 Breno Leitao
      1 Bart Van Assche

  Because Hannes and I have moved a lot of code around we listed
  first.

  Not totally sure how to proceed here. I suppose we need for listed
  the copyright holders an official 'or any later version' change
  Signed-off-by? Things might be difficult as for example Ming is
  no longer with Samsung. Any ideas?

2. nvme.h

   The situation here is a bit simpler as Keith is 'owning' most
   of the lines (monolithic and master branch are almost identically)

   Copyright (c) 2011-2014, Intel Corporation

    104 Keith Busch
     26 Hannes Reinecke
      6 Steven Seungcheol Lee
      3 Sagi Grimberg
      3 Christoph Hellwig
      2 Scott Bauer
      2 Minwoo Im
      2 Martin Wilck
      2 Daniel Wagner
      1 Warner Losh
      1 Tomasz Zawadzki
      1 Ming Lin
      1 Max Gurtovoy
      1 Martin Belanger
      1 Jeffrey Lien
      1 James Smart
      1 Brandon Paupore

  I suppose someone from Intel needs to signed of the 'or any later
  version' thing. Keith do you happen to have a contact for this?

3. nvme-rpmb.c

   This files seems to be owned mostly by Micron.

   Copyright (C) 2020 Micron Techology Inc. All rights reserved.

    933 Hanumanthu H
     52 Daniel Wagner
     35 Hannes Reinecke
     22 Gollu Appalanaidu
      3 naveen kumar
      2 Keith Busch
      1 Klaus Jensen
      1 Ariadne Conill

   Hanumanthu would you be fine to change the license to
   GPL-2.0-or-later?

4. util/parser.c

   This file was provided by Ming and according the commit message
   it is imported from the Linux kernel 4.5. I don't think we can
   get that re-licensed under GPL-2.0-or-later. The good news is
   that it seems we can just remove the file as it is not used.

Thanks
Daniel

[1] https://github.com/linux-nvme/nvme-cli/issues/1508
[2] git blame --line-porcelain FILENAME | sed -n 's/^author //p' | sort -f | uniq -ic | sort -nr

