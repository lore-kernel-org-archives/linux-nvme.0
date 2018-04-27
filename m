From: keith.busch@intel.com (Keith Busch)
Date: Fri, 27 Apr 2018 15:45:26 -0600
Subject: [PATCH] nvme-cli: Wait for device file if not present after
 successful add_ctrl
In-Reply-To: <20180427172939.3571-1-jsmart2021@gmail.com>
References: <20180427172939.3571-1-jsmart2021@gmail.com>
Message-ID: <20180427214526.GE5073@localhost.localdomain>

On Fri, Apr 27, 2018@10:29:39AM -0700, James Smart wrote:
> It's possible for the transport to return very quickly after add_ctrl
> such that the cli may attempt to access the /dev/nvme? device file
> before the udev event has propagated to user space to create the device
> file. In these cases, the open fails with EAGAIN.
> 
> As the add_ctrl call was successful, thus there "should" be a device
> file, if the open fails with EAGAIN delay 500ms and try again. Wait
> for at most 2 seconds for the device file to come into existence.
> 
> Signed-off-by: James Smart <james.smart at broadcom.com>

Applied.
