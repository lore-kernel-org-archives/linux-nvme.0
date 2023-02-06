Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18D8FC05027
	for <linux-nvme@archiver.kernel.org>; Mon,  6 Feb 2023 13:45:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=vK7HEqUJhtQ6o6r+oL9+H0u6sFf+h+7m/QK0qUr7NCY=; b=JHzGjJQG+QYW4/EuQTcv3JS3HB
	/EpWV3NbgQKRpRXsOA6hBVkZJh7CzduJnyen3alXRzKZP+IRAWMqlu7zsaqBl93VurWoVONT5Ntom
	ASzeUjh8AXltKc5abQ9EH7b7FHF3YsbYDzMezGTIK/knmMQqC26VT8B6HgWsy93mhv04uSAci0642
	Molr7xA1VtLcT/wR5Ji/A4ZuzHF1D4v6UHqi4GWU3nDeJV82zxsmij9/ufSVoeQKsUj3F6myFhwnP
	zu06i8LL7VGQDrdmx9i0tq2jL2ZuV0cyfjLZABRD4eWBmYt8WO6wGybP4mQW9hnRNyht13aVeABqC
	8VN2ATBQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pP1nr-008enx-3L; Mon, 06 Feb 2023 13:45:03 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pP1nn-008emu-NH
	for linux-nvme@lists.infradead.org; Mon, 06 Feb 2023 13:45:01 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 9287C33CEE;
	Mon,  6 Feb 2023 13:44:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1675691096; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vK7HEqUJhtQ6o6r+oL9+H0u6sFf+h+7m/QK0qUr7NCY=;
	b=0ALQ6bbRNHudqJ6O5Bh7eYFdlsDTuVX5i1YjweE1gCreXI0KJukzhlWW32nWxiFtZF5ZUw
	/q2VfcD3bvdzQW8xLL30CMdoe+6KE20thbBkB+AY6VH5qsAlsoBL2OH7FP1kutLXJADbXo
	wXPrnoQv0CpM4wIpb4ZkToItbQiKtrc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1675691096;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vK7HEqUJhtQ6o6r+oL9+H0u6sFf+h+7m/QK0qUr7NCY=;
	b=Qt/2Pwqf2AzDqKfIp0JdI7b0OFYLRc96SBQVfeOhRFTXSl3j+veGXsHaljVi+0EIghZ3K/
	zjcGI5k7U+R+bhBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7433D138E7;
	Mon,  6 Feb 2023 13:44:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id I7tJHFgE4WMaMgAAMHmgww
	(envelope-from <dwagner@suse.de>); Mon, 06 Feb 2023 13:44:56 +0000
Date: Mon, 6 Feb 2023 14:44:55 +0100
From: Daniel Wagner <dwagner@suse.de>
To: Keith Busch <kbusch@kernel.org>
Cc: John Meneghini <jmeneghi@redhat.com>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	Hannes Reinecke <hare@suse.de>, Sagi Grimberg <sagi@grimberg.me>,
	Christoph Hellwig <hch@lst.de>,
	"Rose, Charles" <Charles.Rose@dell.com>,
	"Belanger, Martin" <Martin.Belanger@dell.com>,
	Martin Wilck <mwilck@suse.com>
Subject: Re: Timberland nvme-cli/libnvme upstream merge - dbus dependency.
Message-ID: <20230206134455.gdc4pxkxavtk7mbt@carbon.lan>
References: <50a55e73-ae2c-8704-65a0-d47b8bd04192@redhat.com>
 <DM5PR19MB4679B0881914F4022FA5A02798D69@DM5PR19MB4679.namprd19.prod.outlook.com>
 <5dc13dcd-b67a-60b0-0bf1-b03878e0d82b@redhat.com>
 <bcfaa7e1-787f-f7cd-e7e2-5b5f591253e3@redhat.com>
 <10211ed275a0dd73f88d18f111bd4621f356ab0b.camel@suse.com>
 <b28e99b4-0459-e592-140b-61c427073abd@redhat.com>
 <f3f3ed82-f00d-ab81-6de8-d4da01f74296@redhat.com>
 <20230203162213.yyzz5oq2udjzj63q@carbon.lan>
 <Y91EpSYG0Axz5zUQ@kbusch-mbp.dhcp.thefacebook.com>
 <20230206100343.zzy5xxwm3birwqne@carbon.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230206100343.zzy5xxwm3birwqne@carbon.lan>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230206_054459_919291_D2386A8C 
X-CRM114-Status: GOOD (  22.02  )
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

:On Mon, Feb 06, 2023 at 11:03:44AM +0100, Daniel Wagner wrote:
> On Fri, Feb 03, 2023 at 10:30:13AM -0700, Keith Busch wrote:
> > I'm just trying to build this right now on an embedded system, and my goodness,
> > it is fucking painful. It's a bare-bones busybox enviroment with no internet
> > connection. Just getting meson on there was unpleasant, and now the build just
> > gives up with the failed dependencies.
> 
> I am sorry to causing pain. Let's see what how I can help you to make it less
> hurt.
> 
> Is there a reason why you want to build it directly in a busybox environment and
> not using a cross build?
> 
> I agree Meson itself is pretty anyoying in this scenario, though it should be
> possible to use the alternative implementation. Meson is a specification with
> more than one implementation. muon and samurai are written in plain C99 and only
> use a compiler to work. Though I haven't tested this in a while. Let me give it
> a quick test. I suppose it makes sense to add these to our CI build.

The project builds almost out of the box with muon and samurai. There was just
one tiny little problem with the syspathdir which I send out a PR shortly.

Here are the all steps to get this build going with those two tools. It still
depends on json-c being installed previously.



#/bin/bash

if [ ! -d build-tools ]; then

    mkdir build-tools
    pushd build-tools
    git clone --depth 1 https://git.sr.ht/~lattis/muon
    cd muon

    export CC=gcc
    ./tools/bootstrap_ninja.sh build
    ninja=build/samu
    ./bootstrap.sh build
    build/muon setup -Dlibcurl=disabled -Dlibarchive=disabled -Ddocs=disabled -Dsamurai=disabled build
    $ninja -C build
    build/muon -C build test
    popd
fi

export PATH=$(pwd)/build-tools/muon/build:$PATH

if [ ! -d libnvme ]; then
    git clone --depth 1 https://github.com/hreinecke/libnvme.git
fi

if [ ! -d nvme-cli ]; then
    git clone --depth 1 https://github.com/linux-nvme/nvme-cli.git
fi

rm -rf libnvme/build-libnvme nvme-cli/build-nvme-cli

pushd libnvme
muon setup -Dprefix=/tmp/nvme-cli-muon -Dpython=false -Dopenssl=disabled -Dlibdbus=disabled build-libnvme
samu -C build-libnvme
cd build-libnvme
muon install
popd

export PKG_CONFIG_PATH=/tmp/nvme-cli-muon/lib/pkgconfig

pushd nvme-cli
muon setup -Dprefix=/tmp/nvme-cli-muon build-nvme-cli
samu -C build-nvme-cli
cd build-nvme-cli
muon install
popd

