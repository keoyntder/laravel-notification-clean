import React from 'react';
import { useForm, usePage } from '@inertiajs/react';

interface FlashProps {
    success?: string;
}

interface PageProps {
    [key: string]: unknown;
    flash?: FlashProps;
}

interface RegisterForm {
    email: string;
    password: string;
}

export default function Register() {
    const { flash } = usePage<PageProps>().props;

    const { data, setData, post, processing, errors } = useForm<RegisterForm>({
        email: '',
        password: '',
    });

    const handleSubmit = (e: React.FormEvent<HTMLFormElement>) => {
        e.preventDefault();
        post('/register');
    };

    return (
        <div style={styles.container}>
            <form onSubmit={handleSubmit} style={styles.form}>
                <h2>Create Account</h2>

                {flash?.success && (
                    <div style={styles.successAlert}>{flash.success}</div>
                )}

                <div style={styles.field}>
                    <label htmlFor="email">Email</label>

                    <input
                        type="email"
                        id="email"
                        value={data.email}
                        onChange={(e) => setData('email', e.target.value)}
                        style={styles.input}
                        required
                    />

                    {errors.email && (
                        <span style={styles.error}>{errors.email}</span>
                    )}
                </div>

                <div style={styles.field}>
                    <label htmlFor="password">Password</label>

                    <input
                        type="password"
                        id="password"
                        value={data.password}
                        onChange={(e) => setData('password', e.target.value)}
                        style={styles.input}
                        required
                    />

                    {errors.password && (
                        <span style={styles.error}>{errors.password}</span>
                    )}
                </div>

                <button
                    type="submit"
                    disabled={processing}
                    style={styles.button}
                >
                    {processing ? 'Registering...' : 'Register'}
                </button>
            </form>
        </div>
    );
}

const styles = {
    container: {
        display: 'flex',
        justifyContent: 'center',
        alignItems: 'center',
        height: '100vh',
        fontFamily: 'sans-serif',
    },

    form: {
        display: 'flex',
        flexDirection: 'column' as const,
        width: '320px',
        gap: '15px',
        padding: '20px',
        border: '1px solid #ccc',
        borderRadius: '8px',
    },

    field: {
        display: 'flex',
        flexDirection: 'column' as const,
        gap: '5px',
    },

    input: {
        padding: '10px',
        fontSize: '14px',
        borderRadius: '4px',
        border: '1px solid #ccc',
    },

    button: {
        padding: '10px',
        fontSize: '14px',
        backgroundColor: '#4F46E5',
        color: '#fff',
        border: 'none',
        borderRadius: '4px',
        cursor: 'pointer',
    },

    successAlert: {
        color: 'green',
        backgroundColor: '#E6F4EA',
        padding: '10px',
        borderRadius: '4px',
        fontSize: '14px',
    },

    error: {
        color: 'red',
        fontSize: '12px',
    },
};
