From: keith.busch@intel.com (Keith Busch)
Date: Fri, 27 Apr 2018 15:43:40 -0600
Subject: [PATCH] nvme-cli: show partial results if controller fails
 during list and list-subsys
In-Reply-To: <20180427172733.3325-1-jsmart2021@gmail.com>
References: <20180427172733.3325-1-jsmart2021@gmail.com>
Message-ID: <20180427214339.GD5073@localhost.localdomain>

On Fri, Apr 27, 2018@10:27:33AM -0700, James Smart wrote:
> For the current versions of "list" and "list-subsys":
> If a command to a controller fails, which is possible if the controller
> is going through a reconnect, the operation will fail and all results
> gathered up to that point is dropped. Thus, the operation shows no
> results.
> 
> Revise the commands so that they will report an error if one of the
> controllers fail, but will now skip over the failing controller and
> continue with the next one.
> 
> Signed-off-by: James Smart <james.smart at broadcom.com>

Looks good, applied.
