Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1164AC79FBF
	for <linux-nvme@archiver.kernel.org>; Thu, 10 Sep 2026 17:00:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Message-ID:References:In-Reply-To:Subject:Cc:To:From:Date:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=kpbngov4RIuLBylCtoJAheo73LrZm+/bp+JAwq7KaTM=; b=JfCXmNPZ8Ia317Q8DLf8pYrtc4
	T2ke9NY4Bchv6cp7xQuL5prLa+O47ZBFFBWXpMK4O9ypSgnPNxAX9yYacDLED2L2zUwuA5lLKp/BY
	uZsh15M//pQtnaA071+3ZK5Me4JrLI+q9WhnnX08tiLjpVB2JqGjt2OBOgo1+7YlXMqTSNpl0OiD9
	LOd1ADc+4B3Jw2Zp+IQygULm8nzkdL2Izy7gV6/lfqAxWho/gUnFiaCLDeJpIK8j1+8clUqjRuMi0
	8jXoDdAsOCZg+0ZY4jKYUM54ZTsLjkhY51kJ8qllN74CIxiMGB9AIdWW7RHiHBE1LCITFniWBz5hN
	aoFfs/xg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x4i8g-0000000F13r-3ayu;
	Thu, 10 Sep 2026 17:00:42 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x4gRm-0000000EjkT-0pnX;
	Thu, 10 Sep 2026 15:12:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
	:Message-ID:References:In-Reply-To:Subject:Cc:To:From:Date:MIME-Version:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=kpbngov4RIuLBylCtoJAheo73LrZm+/bp+JAwq7KaTM=; b=WifLxz7+mcy9eukpMHYi9LcuAo
	Kwo+Nlh8Zi/JWZ6dWnWp/f+kIPqeIGWO4Pwx6ZUg49JT06yeTmKsx3XQ5JKnYKqBz6ENgyFJme0b7
	vrZLFlcGNnX03hDhawxS3RxRrIWIByGsTmhaSi7jwfft3maWqTqKhIHtCM90BVrqmCtdt6SWCYT4M
	NFnZ1tAKJSP01TGpXVYBXkoZh5O7mo4rh8qelLHkb1IP9Pr/hrhrZn86hY7Oh4I5SiOtLWNooq4jE
	l6UXWJJfVJUXtC2XIClFdD9iXbAwE6a2EVwkamvLMn048jY9XjWgpjiaGD3NDIJYOrjwRNxFQ+09N
	1EmInQeQ==;
Received: from mail.tipi-net.de ([194.13.80.246])
	by desiato.infradead.org with esmtps (Exim 4.99.2 #2 (Red Hat Linux))
	id 1x4gRi-00000002eqB-3eVp;
	Thu, 10 Sep 2026 15:12:16 +0000
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 47C55A4169;
	Thu, 10 Sep 2026 17:11:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1789053121; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=kpbngov4RIuLBylCtoJAheo73LrZm+/bp+JAwq7KaTM=;
	b=Hpdx1B0RklFI70C6JovHFAuJwyocwPn/ocqTHpQdmGbpphdH1JIBcqr/YtbjcnbJ6ZtOfU
	7pePFoQRb7XlSWPffSMETd4TTPd0pZvW3piaRLHiSzL0tVz45TkmmC2BocAwDgRAgvuxw0
	XQneeJ/zpQOFh0La0WXgAbUPdKcd8z5ra8QU6CZxRLdgdCdeyMNYnQxqtLLs9ZeTuL8OPy
	5sN4KooGBkX/6RmSaBGO1l2v7csMS5zxmT0Ku9YXijilyY5qmWPpIUxr4cN1jVcamG22ON
	xBaiIr0TLZ8mbFDjdj4iXDwo/xy7DrVzyM+U/yDAqv8gNlxRbnB64AfiV66POA==
MIME-Version: 1.0
Date: Thu, 10 Sep 2026 17:11:33 +0200
From: Nicolai Buchwitz <nb@tipi-net.de>
To: Fernando Fernandez Mancera <fmancera@suse.de>
Cc: netdev@vger.kernel.org, horms@kernel.org, kuba@kernel.org, pabeni@redhat.com, edumazet@google.com, davem@davemloft.net, Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, Tony Nguyen <anthony.l.nguyen@intel.com>, Przemek Kitszel <przemyslaw.kitszel@intel.com>, Elad Nachman <enachman@marvell.com>, Saeed Mahameed <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>, Edward Cree <ecree.xilinx@gmail.com>, Maxime Chevallier <maxime.chevallier@bootlin.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>, Arend van Spriel <arend.vanspriel@broadcom.com>, Miri Korenblit <miriam.rachel.korenblit@intel.com>, Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>, Saurav Kashyap <skashyap@marvell.com>, Javed Hasan <jhasan@marvell.com>, GR-QLogic-Storage-Upstream@marvell.com, "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, "Martin K. Petersen" <mkp@kernel.org>, Nilesh Javali <njavali@marvell.com>, Manish Rangankar <mrangankar@marvell.com>, Varun Prakash <varun@chelsio.com>, Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, David Howells <dhowells@redhat.com>, Marc Dionne <marc.dionne@auristor.com>, Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, Chuck Lever <cel@kernel.org>, Jeff Layton <jlayton@kernel.org>, NeilBrown <neil@brown.name>, Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>, Marek Lindner <marek.lindner@mailbox.org>, Simon Wunderlich <sw@simonwunderlich.de>, Antonio Quartulli <antonio@mandelbit.com>, Sven Eckelmann <sven@narfation.org>, Nikolay Aleksandrov <razor@blackwall.org>, Pablo Neira Ayuso <pablo@netfilter.org>, Florian Westphal <fw@strlen.de>, Phil Sutter <phil@nwl.cc>, Johannes Berg <johannes@sipsolutions.net>, Matthieu Baerts <matttbe@kernel.org>, Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>, Julian Anastasov <ja@ssi.bg>, Aaron Conole <aconole@redhat.com>, Eelco Chaudron <echaudro@redhat.com>, Ilya Maximets <i.maximets@ovn.org>, Allison Henderson <achender@kernel.org>, Jamal Hadi Salim <jhs@mojatatu.com>, Jiri Pirko <jiri@resnulli.us>, Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>, Xin Long <lucien.xin@gmail.com>, "D. Wythe" <alibuda@linux.alibaba.com>, Dust Li <dust.li@linux.alibaba.com>, Sidraya Jayagond <sidraya@linux.ibm.com>, Mahanta Jambigi <mjambigi@linux.ibm.com>, Tony Lu <tonylu@linux.alibaba.com>, Wen Gu <guwen@linux.alibaba.com>, Jon Maloy <jmaloy@redhat.com>, Tung Quang Nguyen <tung.quang.nguyen@est.tech>, Steffen Klassert <steffen.klassert@secunet.com>, Herbert Xu <herbert@gondor.apana.org.au>, Casey Schaufler <casey@schaufler-ca.com>, Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, Vikas Gupta <vikas.gupta@broadcom.com>, Bhargava Marreddy <bhargava.marreddy@broadcom.com>, Rajashekar Hudumula <rajashekar.hudumula@broadcom.com>, =?UTF-8?Q?Markus_Bl=C3=B6chl?= <markus@blochl.de>, Arnd Bergmann <arnd@arndb.de>, Heiner Kallweit <hkallweit1@gmail.com>, Florian Fainelli <florian.fainelli@broadcom.com>, Krzysztof Kozlowski <krzk@kernel.org>, Qingfang Deng <qingfang.deng@linux.dev>, Julian Braha <julianbraha@gmail.com>, Ethan Nelson-Moore <enelsonmoore@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Eric Biggers <ebiggers@kernel.org>, Ard Biesheuvel <ardb@kernel.org>, Neal Cardwell <ncardwell@google.com>, Kuniyuki Iwashima <kuniyu@google.com>, Willem de Bruijn <willemb@google.com>, Alyssa Ross <hi@alyssa.is>, Joel Granados <joel.granados@kernel.org>, Oleg Nesterov <oleg@redhat.com>, linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org, intel-wired-lan@lists.osuosl.org, oss-drivers@corigine.com,
 linux-net-drivers@amd.com, linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org, linux-wireless@vger.kernel.org, brcm80211@lists.linux.dev, brcm80211-dev-list.pdl@broadcom.com, linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org, target-devel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-afs@lists.infradead.org, linux-nfs@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org, bridge@lists.linux.dev, netfilter-devel@vger.kernel.org, coreteam@netfilter.org, mptcp@lists.linux.dev, lvs-devel@vger.kernel.org, dev@openvswitch.org, rds-devel@oss.oracle.com, linux-sctp@vger.kernel.org, linux-s390@vger.kernel.org, tipc-discussion@lists.sourceforge.net, linux-security-module@vger.kernel.org
Subject: Re: [PATCH 01/13 net-next] net: ipv4: introduce CONFIG_IPV4 to
 decouple the IPv4 stack
In-Reply-To: <20260910144914.8025-2-fmancera@suse.de>
References: <20260910144914.8025-1-fmancera@suse.de>
 <20260910144914.8025-2-fmancera@suse.de>
Message-ID: <aeb37452e976f5d44540ac3a0999d07b@tipi-net.de>
X-Sender: nb@tipi-net.de
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260910_161215_437647_3B69E810 
X-CRM114-Status: GOOD (  17.25  )
X-Mailman-Approved-At: Thu, 10 Sep 2026 10:00:41 -0700
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

Hi Fernando,

Thanks for the patch - after nearly 30 years IPv6 should be mature 
enough :)

On 10.9.2026 16:48, Fernando Fernandez Mancera wrote:
> Historically, the IPv4 protocol has been linked to the core INET
> subsystem. Because shared infrastructure like the TCP/UDP engine,
> routing or INET hashtables live inside net/ipv4/, it has been 
> impossible
> to compile a kernel with only IPv6 support.
> 
> This patch introduces the CONFIG_IPV4 Kconfig symbol, which is set to
> 'def_bool y' for now. This does not allow to completely disable the
> IPv4 stack yet but it lays the necessary build-system work for that
> goal.
> 
> In addition, multiple subsystems Kconfig symbols across networking
> features like tunnels, drivers and filesystems have been adjusted to
> depend on IPv4. Keep on mind that follow-up work is required to convert
> the Kconfig symbol to bool and remove the dependency on IPv4 where it
> makes sense.
> 
> Signed-off-by: Fernando Fernandez Mancera <fmancera@suse.de>
> ---

> [...]

> diff --git a/net/packet/Kconfig b/net/packet/Kconfig
> index 2997382d597c..00fda9e08cb0 100644
> --- a/net/packet/Kconfig
> +++ b/net/packet/Kconfig
> @@ -5,6 +5,7 @@
> 
>  config PACKET
>  	tristate "Packet socket"
> +	depends on IPV4

   depends on IPV4 || !INET

Otherwise this would break existing configs with INET=n. The same 
applies
to other affected options that currently permit INET=n.

> [...]

Thanks,
Nicolai

