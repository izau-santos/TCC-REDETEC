const login = async (username, password) => {
  try {
    const response = await fetch('http://192.168.10.240:7140/api/Usuarios/login', {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
      },
      body: JSON.stringify({ username, password }),
    });

    if (!response.ok) {
      // Se a resposta não for bem-sucedida, lançar um erro
      const errorData = await response.json();
      throw new Error(`Erro ${response.status}: ${errorData.message || 'Erro desconhecido'}`);
    }

    const data = await response.json();
    return data;
  } catch (error) {
    console.error('Erro ao fazer login:', error);
    throw error;
  }
};
