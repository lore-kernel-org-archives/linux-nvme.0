From: keith.busch@intel.com (Keith Busch)
Date: Thu, 16 Apr 2015 16:12:07 +0000 (UTC)
Subject: [PATCH 5/5 v2] nvme: LightNVM support
In-Reply-To: <057301d0785e$9f8e81c0$deab8540$@thebergstens.com>
References: <1429101284-19490-1-git-send-email-m@bjorling.me>
 <1429101284-19490-6-git-send-email-m@bjorling.me>
 <alpine.LNX.2.00.1504161433110.32385@localhost.lm.intel.com>
 <694D3575-E49B-45BB-8E48-7188169B75F0@paletta.io>
 <alpine.LNX.2.00.1504161528010.32385@localhost.lm.intel.com>
 <057301d0785e$9f8e81c0$deab8540$@thebergstens.com>
Message-ID: <alpine.LNX.2.00.1504161607020.32385@localhost.lm.intel.com>

On Thu, 16 Apr 2015, James R. Bergsten wrote:
> My two cents worth is that it's (always) better to put ALL the commands into
> one place so that the entire set can be viewed at once and thus avoid
> inadvertent overloading of an opcode.  Otherwise you don't know what you
> don't know.

Yes, but these are two different command sets.
