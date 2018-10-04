From: sagi@grimberg.me (Sagi Grimberg)
Date: Thu, 4 Oct 2018 14:06:36 -0700
Subject: [PATCH 09/11] nvmet: Allow all hosts access to the Discovery
 subsystem
In-Reply-To: <1538668171-232344-10-git-send-email-jay.e.sternberg@intel.com>
References: <1538668171-232344-1-git-send-email-jay.e.sternberg@intel.com>
 <1538668171-232344-10-git-send-email-jay.e.sternberg@intel.com>
Message-ID: <3cc04e4c-eab9-98db-2437-e284020377a1@grimberg.me>

The change log should be:

     nvmet: allow host connect even if no allowed subsystems are exported

     It is perfectly valid that a host connects to a discovery subsystem
     and gets an empty discovery log page since no subsystems are
     provisioned to it. No reason to disallow connecting to the discovery
     subsystem all together.
