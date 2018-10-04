From: sagi@grimberg.me (Sagi Grimberg)
Date: Thu, 4 Oct 2018 14:11:54 -0700
Subject: [PATCH 11/11] nvmet: Enable Discovery Controller AENs
In-Reply-To: <1538668171-232344-12-git-send-email-jay.e.sternberg@intel.com>
References: <1538668171-232344-1-git-send-email-jay.e.sternberg@intel.com>
 <1538668171-232344-12-git-send-email-jay.e.sternberg@intel.com>
Message-ID: <aa5997e7-117c-8e38-9c42-c039387d37d1@grimberg.me>

> Add functions to find connections requesting Discovery Change events
> and send a notification.
> 
> Call these functions each time there is a configfs change that effects
> the Discover Log Pages.

The change log needs to improve, we need to describe which hosts should
receive discovery AEN when subsystem acls change and when subsystem is
added/removed to/from a port.
