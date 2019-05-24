From: kbusch@kernel.org (Keith Busch)
Date: Fri, 24 May 2019 14:34:54 -0600
Subject: [PATCH 1/4] nvme: separate out nvme_ctrl_state_name()
In-Reply-To: <20190520063624.50338-2-hare@suse.de>
References: <20190520063624.50338-1-hare@suse.de>
 <20190520063624.50338-2-hare@suse.de>
Message-ID: <20190524203454.GA17321@localhost.localdomain>

On Sun, May 19, 2019@11:36:21PM -0700, Hannes Reinecke wrote:
> Separate out nvme_ctrl_state_name() to return the controller state
> as a string.
> 
> Signed-off-by: Hannes Reinecke <hare at suse.com>
> Reviewed-by: James Smart <james.smart at broadcom.com>
> Reviewed-by: Minwoo Im <minwoo.im.dev at gmail.com>

LGTM

Reviewed-by: Keith Busch <kbusch at kernel.org>
