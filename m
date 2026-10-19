Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91615CCF2E6
	for <linux-nvme@archiver.kernel.org>; Mon, 19 Oct 2026 14:43:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+REiuhOk6WK+CD+uZ6yHzg7Wu7MxEiEhQ/9njhRYMBI=; b=K3FNF9YsgTweRdR5xsfuyjXmY6
	3ir9WWutaLH+9aaqEr4mqItHOVWDdUA4g47BELKuN962WpWi6fSktfVakLKaT+Ls/K7H7xCjHNqL+
	htkf5VnIHgYPefpuAt1J34u2W7yxYsoJcqmRcnBg/SLjCME1+4V1ngEQuUjx0EQsYlllP5sLS5En9
	aEGnOCTrpAXjVC8D8PB2hLclxvAYMN1ZQB+UBxyA5XPOrgeMsCXAsFC2j0IZBZL6j3g1P4Z8RhMDn
	uWAKYLHcF37alHfKQxb4ucJp+ty7KU9TUNHqkKpYn3bTb5vHPD+CsIS3NSXIf65Yzj4KC6CQ6QOSn
	OwKVyPuw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xIoag-00000007ltw-2r67;
	Mon, 19 Oct 2026 14:43:54 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xIoag-00000007ltj-19dt
	for linux-nvme@lists.infradead.org;
	Mon, 19 Oct 2026 14:43:54 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id B2A97601FD
	for <linux-nvme@lists.infradead.org>; Mon, 19 Oct 2026 14:43:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E0761F000C4;
	Mon, 19 Oct 2026 14:43:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792421033;
	bh=+REiuhOk6WK+CD+uZ6yHzg7Wu7MxEiEhQ/9njhRYMBI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=fCtbdGkFAWYUnZM067PZpanw2OkkMQgp1vAlfPaliM3aqqwu3a10lrrnSlBbfYJ8u
	 n4DaiYuYj8Hi6zKwJawPjUKjZU6hnq6Bm8fquW7hZ9i2Bsy9LcvMij4OlAVMHwcsQa
	 +bkqlVFb4WR/GtrLE+oDZPCATQNtNCEhF3fmas85X891L5yBJZCbyYMuBRd5mi1WmO
	 OCw+eq8UE+BDnbgMIv6Oia1BbQCQi9E+a34Tmgjvr3epG8tnwxkmmF9npfDHgpNRZQ
	 9s8TutqFvqV3c+41hbI5UE6hHubM+VPvLAjazi6QAHmCN/1+M8GqNsomAIkvCejr/0
	 +2WdUJr9qPj7Q==
Message-ID: <sashiko-outbox-177482@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH AUTOSEL 6.18-5.15] nvme-tcp: look up host_iface in the
 current netns
To: "Sasha Levin" <sashal@kernel.org>
Cc: linux-nvme@lists.infradead.org
In-Reply-To: <20261019135441.1420968-231-sashal@kernel.org>
References: <20261019135441.1420968-1-sashal@kernel.org>
 <20261019135441.1420968-231-sashal@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 19 Oct 2026 14:43:52 +0000
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
Reply-To: sashiko-reviews@lists.linux.dev
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Critical] nvme-tcp: use-after-free in nvme_tcp_alloc_ctrl() via __dev_ge=
t_by_name()
--

commit 04aa71fe23c7dec86f240fa7773c4020c75d2bb7
Author: Geliang Tang <geliang@kernel.org>

nvme-tcp: look up host_iface in the current netns

This commit changes nvme_tcp_alloc_ctrl() to look up opts->host_iface in
current->nsproxy->net_ns rather than init_net so that interfaces in the
calling task's network namespace can be found.

> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
> index 9a96df1a511c0..fb6858023f19d 100644
> --- a/drivers/nvme/host/tcp.c
> +++ b/drivers/nvme/host/tcp.c
> @@ -2935,7 +2935,8 @@ static struct nvme_tcp_ctrl *nvme_tcp_alloc_ctrl(st=
ruct device *dev,
>  	}
> =20
>  	if (opts->mask & NVMF_OPT_HOST_IFACE) {
> -		if (!__dev_get_by_name(&init_net, opts->host_iface)) {
> +		if (!__dev_get_by_name(current->nsproxy->net_ns,
> +				       opts->host_iface)) {

[Severity: Critical]
Is it safe to call __dev_get_by_name() here without holding rtnl_lock()?

When userspace writes connection parameters with host_iface=3D<name> to
/dev/nvme-fabrics, the call chain:

  nvmf_dev_write()
    -> nvmf_create_ctrl()
      -> nvme_tcp_create_ctrl()
        -> nvme_tcp_alloc_ctrl()

runs in sleepable process context holding only nvmf_dev_mutex, with
neither rtnl_lock() nor rcu_read_lock() held.

In net/core/dev.c, __dev_get_by_name() requires the RTNL semaphore and
calls netdev_name_node_lookup(), which traverses the per-netns hash bucket
with non-RCU list primitives:

net/core/dev.c:netdev_name_node_lookup() {
	struct hlist_head *head =3D dev_name_hash(net, name);
	struct netdev_name_node *name_node;

	hlist_for_each_entry(name_node, head, hlist)
		if (!strcmp(name_node->name, name))
			return name_node;
	return NULL;
}

net/core/dev.c:__dev_get_by_name() {
	struct netdev_name_node *node_name;

	node_name =3D netdev_name_node_lookup(net, name);
	return node_name ? node_name->dev : NULL;
}

If a network device in current->nsproxy->net_ns is concurrently
unregistered via unregister_netdevice_many_notify() ->
rollback_registered_many() (which unlinks the node in unlist_netdevice(),
waits for an RCU grace period via synchronize_net(), and then frees the
nodes via netdev_name_node_alt_flush() and netdev_name_node_free()), has an
altname deleted via netdev_name_node_alt_destroy() ->
__netdev_name_node_alt_destroy(), or is renamed via dev_change_name(),
neither synchronize_net() nor call_rcu() will wait for a preempted reader
in nvme_tcp_alloc_ctrl().

Could this trigger a use-after-free on name_node or name_node->name during
the hash list traversal, and should this lookup use dev_get_by_name_rcu()
under rcu_read_lock() (or netdev_name_in_use()) instead?

>  			pr_err("invalid interface passed: %s\n",
>  			       opts->host_iface);
>  			ret =3D -ENODEV;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261019135441.1420=
968-231-sashal@kernel.org?part=3D1

