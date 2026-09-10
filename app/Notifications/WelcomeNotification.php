<?php

namespace App\Notifications;

use Illuminate\Bus\Queueable;
use Illuminate\Notifications\Messages\MailMessage;
use Illuminate\Notifications\Notification;

class WelcomeNotification extends Notification
{
    use Queueable;

    public function via(object $notifiable): array
    {
        return ['mail'];
    }

    public function toMail(object $notifiable): MailMessage
    {
        return (new MailMessage)
            ->subject('Welcome to Our Application!')
            ->greeting('Hello!')
            ->line('Thank you for registering. Your account has been successfully created.')
            ->action('Go to Dashboard', url('/'))
            ->line('If you did not create an account, no further action is required.');
    }
}
